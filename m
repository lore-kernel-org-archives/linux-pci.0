Return-Path: <SRS0=T4fo=FR=gmail.com=valmikibow@kernel.org>
Return-Path: <SRS0=T4fo=FR=gmail.com=valmikibow@kernel.org>
To: linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, sbodomerle@gmail.com,
 rjui@broadcom.com
From: valmiki <valmikibow@gmail.com>
Subject: Affinity on non MSI-X interrupts
Message-ID: <714a8d82-c4b0-9661-5b78-ed0d87a0a5fc@gmail.com>
Date: Sat, 24 Feb 2018 00:47:00 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

Does multi MSI interrupts will also be set and routed by affinity ?

In drivers/pci/host/pcie-iproc-msi.c interrupt handler there is do while 
loop.
head = iproc_msi_read_reg(msi, IPROC_MSI_EQ_HEAD,
				  eq) & IPROC_MSI_EQ_MASK;
	do {
		tail = iproc_msi_read_reg(msi, IPROC_MSI_EQ_TAIL,
					  eq) & IPROC_MSI_EQ_MASK;

		.....
		}

		
		 */
	} while (true);

What happens if two multi MSI cards are connected and continuously 
running traffic ? Will this handler ever come out? wont this stall CPU ?
Will the interrupts be routed to different CPU's in this case also?

Regards,
Valmiki


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
