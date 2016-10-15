Return-Path: <marc.zyngier@arm.com>
Return-Path: <marc.zyngier@arm.com>
Date: Sat, 15 Oct 2016 14:14:01 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: Why MSI is limited to 32 interrupts maximum
Message-ID: <20161015141401.70d95035@why.wild-wind.fr.eu.org>
In-Reply-To: <8520D5D51A55D047800579B0941471982594B0F3@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <8520D5D51A55D047800579B0941471982594B0F3@XAP-PVEXMBX01.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Sat, 15 Oct 2016 12:37:55 +0000
Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:

Hi Bharat,

> Can anyone tell why MSI interrupts are limited to maximum 32
> interrupts, even though we have 16bit message data register ?

That's the very definition of the original PCI MSI: Up to 32
consecutive interrupts per function, and a single doorbell address.
MSI-X lifts that restriction and offers up to 2048 interrupts that do
not have to be contiguous can target individual doorbells. Assuming
your MSI controller advertises MSI-X support and that your devices do
support it as well, you'll be able to enjoy those.

> 
> Regards,
> Bharat
> 
> 
> This email and any attachments are intended for the sole use of the
> named recipient(s) and contain(s) confidential information that may
> be proprietary, privileged or copyrighted under applicable law. If
> you are not the intended recipient, do not read, copy, or forward
> this email message or any attachments. Delete this email message and
> any attachments immediately.
> 

Please fix your email not to carry such disclaimer (or use a private
email address if you can't work around your company policy). Posting
confidential information on a public mailing list feels a bit silly.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
