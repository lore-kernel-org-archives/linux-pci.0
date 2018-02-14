Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v12 6/9] LPC: Support the LPC host on Hip06/Hip07 with DT
 bindings
To: dann frazier <dann.frazier@canonical.com>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
 <1516725385-24535-7-git-send-email-john.garry@huawei.com>
 <20180213184123.GA11446@xps13.dannf>
CC: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
        <mark.rutland@arm.com>, <olof@lixom.net>, <hanjun.guo@linaro.org>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-pci@vger.kernel.org>, <minyard@acm.org>,
        <devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <rdunlap@infradead.org>,
        Zhichang Yuan <yuanzhichang@hisilicon.com>,
        "Zou Rongrong" <zourongrong@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <78ff2d7a-201f-8fff-9acc-ae23a65ce18f@huawei.com>
Date: Wed, 14 Feb 2018 11:35:24 +0000
MIME-Version: 1.0
In-Reply-To: <20180213184123.GA11446@xps13.dannf>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dann,

>> + */
>> +static int
>> +hisilpc_target_in(struct hisilpc_dev *lpcdev, struct lpc_cycle_para *para,
>> +		  unsigned long ptaddr, unsigned char *buf,
>> +		  unsigned long opcnt)
>> +{
>> +	unsigned long cnt_per_trans;
>> +	unsigned int cmd_word;
>> +	unsigned int waitcnt;
>> +	int ret;
>> +
>> +	if (!buf || !opcnt || !para || !para->csize || !lpcdev)
>> +		return -EINVAL;
>> +
>> +	cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_READ;
>> +	waitcnt = LPC_PEROP_WAITCNT;
>> +	if (!(para->opflags & FG_INCRADDR_LPC)) {
>> +		cmd_word |= LPC_CMD_SAMEADDR;
>> +		waitcnt = LPC_MAX_WAITCNT;
>> +	}
>> +
>> +	ret = 0;
>> +	cnt_per_trans = (para->csize == 1) ? opcnt : para->csize;
>> +	for (; opcnt && !ret; cnt_per_trans = para->csize) {
>> +		unsigned long flags;
>> +
>> +		/* whole operation must be atomic */
>> +		spin_lock_irqsave(&lpcdev->cycle_lock, flags);
>> +
>> +		writel_relaxed(cnt_per_trans, lpcdev->membase + LPC_REG_OP_LEN);
>> +
>> +		writel_relaxed(cmd_word, lpcdev->membase + LPC_REG_CMD);
>> +
>> +		writel_relaxed(ptaddr, lpcdev->membase + LPC_REG_ADDR);
>> +
>> +		writel(LPC_START_WORK, lpcdev->membase + LPC_REG_START);
>> +
>> +		/* whether the operation is finished */
>> +		ret = wait_lpc_idle(lpcdev->membase, waitcnt);
>> +		if (!ret) {
>> +			opcnt -= cnt_per_trans;
>
> Do we need to check for an underflow here?

I think that underflow is ensured not to happen.

Regardless, I find this code hard to follow myself, so I will rewrite a 
bit of this to make it more straightforward.

>
>> +			for (cnt_per_trans--; cnt_per_trans--; buf++)
>> +				*buf = readb_relaxed(lpcdev->membase +
>> +					LPC_REG_RDATA);
>> +			*buf = readb(lpcdev->membase + LPC_REG_RDATA);
>> +		}
>> +
>> +		spin_unlock_irqrestore(&lpcdev->cycle_lock, flags);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * hisilpc_target_out - trigger a series of lpc cycles to write required
>> + *			data to target peripheral.
>> + * @lpcdev: pointer to hisi lpc device
>> + * @para: some parameters used to control the lpc I/O operations
>> + * @ptaddr: the lpc I/O target port address
>> + * @buf: where the data to be written is stored
>> + * @opcnt: how many I/O operations required
>> + *
>> + * Only one byte data is read each I/O operation.
>
> s/read/written/ ?

Right

>
>> + * Returns 0 on success, non-zero on fail.
>> + *
>> + */
>> +static int
>> +hisilpc_target_out(struct hisilpc_dev *lpcdev, struct lpc_cycle_para *para,
>> +		   unsigned long ptaddr, const unsigned char *buf,
>> +		   unsigned long opcnt)
>> +{
>> +	unsigned long cnt_per_trans;
>> +	unsigned int cmd_word;
>> +	unsigned int waitcnt;
>> +	int ret;
>> +
>> +	if (!buf || !opcnt || !para || !lpcdev)
>> +		return -EINVAL;
>> +
>> +	/* default is increasing address */
>> +	cmd_word = LPC_CMD_TYPE_IO | LPC_CMD_WRITE;
>> +	waitcnt = LPC_PEROP_WAITCNT;
>> +	if (!(para->opflags & FG_INCRADDR_LPC)) {
>> +		cmd_word |= LPC_CMD_SAMEADDR;
>> +		waitcnt = LPC_MAX_WAITCNT;
>> +	}
>> +
>> +	ret = 0;
>> +	cnt_per_trans = (para->csize == 1) ? opcnt : para->csize;
>> +	for (; opcnt && !ret; cnt_per_trans = para->csize) {
>> +		unsigned long flags;
>> +
>> +		spin_lock_irqsave(&lpcdev->cycle_lock, flags);
>> +
>> +		writel_relaxed(cnt_per_trans, lpcdev->membase + LPC_REG_OP_LEN);
>> +		writel_relaxed(cmd_word, lpcdev->membase + LPC_REG_CMD);
>> +		writel_relaxed(ptaddr, lpcdev->membase + LPC_REG_ADDR);
>> +
>> +		opcnt -= cnt_per_trans;
>
> Underflow check needed?

As above

>
>  -dann
>

Thanks,
John


