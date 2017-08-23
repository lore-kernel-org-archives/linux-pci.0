Return-Path: <SRS0=+xF7=7Z=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=+xF7=7Z=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v7 1/2] PCI: iproc: Retry request when CRS returned from
 EP
To: Oza Oza <oza.oza@broadcom.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 Andy Gospodarek <gospo@broadcom.com>, linux-pci <linux-pci@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>,
 Timur Tabi <timur@codeaurora.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1503331124-25029-1-git-send-email-oza.oza@broadcom.com>
 <1503331124-25029-2-git-send-email-oza.oza@broadcom.com>
 <20170822203347.GE6948@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPctfRhf8zkeoGN73N-vm8Adn7SwieAAeRKrjhY7m_RkEw@mail.gmail.com>
 <20170823135140.GA8498@bhelgaas-glaptop.roam.corp.google.com>
 <CAMSpPPf5c2=zO81-7TEidOHbB8K0L3T2_wV4+9Gem5DB6rHWFw@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <eb01a01b-ee8a-1c51-69ba-838bfe94b6f6@codeaurora.org>
Date: Wed, 23 Aug 2017 11:52:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAMSpPPf5c2=zO81-7TEidOHbB8K0L3T2_wV4+9Gem5DB6rHWFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Oza,

> In working Enumuration case I get following:
> [    9.125976] pci 0000:00:00.0: bridge configuration invalid ([bus
> 00-00]), re-configuring
> [    9.134267] where=0x0 val=0xffff0001
> [    9.146946] where=0x0 val=0xffff0001
> [    9.158943] where=0x0 val=0xffff0001
> [    9.170945] where=0x0 val=0xffff0001
> [    9.186945] where=0x0 val=0xffff0001
> [    9.210944] where=0x0 val=0xffff0001
> [    9.250943] where=0x0 val=0xffff0001
> [    9.322942] where=0x0 val=0xffff0001
> [    9.458943] where=0x0 val=0xffff0001
> [    9.726942] where=0x0 val=0x9538086    >> actual vendor and device id.
> 
> so I think I have to retry in RC driver, so the old code still holds good.
> except that I have to do factoring out
You need to return 0xFFFF0001 for vendor ID register and return 0xFFFFFFFF for
other registers like COMMAND register during the CRS period.

> 
> please let me know If I missed anything, or you want me to try anything else.

Sinan
