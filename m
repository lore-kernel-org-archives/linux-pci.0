Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] PCI: designware: ensure ATU is enabled before
 IO/conf space accesses
References: <1450442339-18765-1-git-send-email-stanimir.varbanov@linaro.org>
 <1450442339-18765-2-git-send-email-stanimir.varbanov@linaro.org>
 <CAHM4w1kzGKahVOTdTxMciZBs81U9EVoSYPgCw9=ph3R9vSwCwQ@mail.gmail.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <568A823F.5090209@mm-sol.com>
Date: Mon, 4 Jan 2016 16:31:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAHM4w1kzGKahVOTdTxMciZBs81U9EVoSYPgCw9=ph3R9vSwCwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/18/2015 04:41 PM, Pratyush Anand wrote:
> On Fri, Dec 18, 2015 at 6:08 PM, Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>> There is no guarantees that enabling ATU will hit the hardware
>> immediately, and subsequent accesses to configuration / IO spaces
>> are reliable. So fixing this by read back PCIE_ATU_CR2 register
>> just after writing.
>>
>> Without such a fix the PCI device enumeration during kernel boot
>> is not reliable, and reading configuration space for particular
>> PCI device on the bus returns zero aka no device.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> 
> Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

Bjorn, Do you want to resend the whole patchset with collected acks and
tested tags?


-- 
regards,
Stan
