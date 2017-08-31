Return-Path: <SRS0=G5cy=AB=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=G5cy=AB=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170824164633.GI31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170821192907.8695-1-ard.biesheuvel@linaro.org> <20170824164633.GI31858@bhelgaas-glaptop.roam.corp.google.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 31 Aug 2017 20:21:54 +0100
Message-ID: <CAKv+Gu_=utJ0vrWqgKq4Nrfg0AHb00tkM-0KO2UgGFu1VHdmvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] pci: add support for firmware initialized designware RCs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>,
	Graeme Gregory <graeme.gregory@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Jingoo Han <jingoohan1@gmail.com>, Leif Lindholm <leif.lindholm@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 24 August 2017 at 17:46, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Aug 21, 2017 at 08:29:04PM +0100, Ard Biesheuvel wrote:
>> UEFI based systems incorporating a Synopsys Designware PCIe controller
>> in RC mode will typically configure it before entering the OS. If this
>> configuration is fully static and ECAM compliant, there is no need to
>> expose particulars of the device to the OS, and we can simply describe
>> it as "pci-host-ecam-generic".
>
> I *love* the idea of moving more of this to firmware.

Enough to consider the v3 of this series for v4.14? Rob has acked the
binding, and as far as I am aware. it is ultimately up to you whether
and when you take them as a pair. Also, I don't mind being listed as
maintainer and/or reviewer either if it helps.

Thanks,
Ard.
