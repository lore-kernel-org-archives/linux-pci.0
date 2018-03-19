Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Mar 2018 11:38:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Message-ID: <20180319083850.tglknmwwybdhahfl@mwanda>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 18, 2018 at 10:53:02PM +0800, Jia-Ju Bai wrote:
> hv_pci_onchannelcallback() is not called in atomic context.
> 
> The call chain ending up at hv_pci_onchannelcallback() is:
> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
> hv_pci_probe() is only set as ".probe" in hv_driver 
> structure "hv_pci_drv".
> 

Your static analysis tool is faulty and apparently so is Smatch.

$ smdb function_ptrs hv_pci_onchannelcallback

Says it can't find a caller.  When I look for function pointers I get:

$ smdb function_ptr hv_pci_onchannelcallback
hv_pci_onchannelcallback =  'hv_pci_onchannelcallback' , 'vmbus_open param 5' , '(struct vmbus_channel)->onchannel_callback' , '__read_once_size param 0'

Anyway the call tree is:

vmbus_chan_sched() <-- takes rcu_read_lock();
-> vmbus_channel_isr()
   -> channel->onchannel_callback() -> which is hv_pci_onchannelcallback()

regards,
dan carpenter
