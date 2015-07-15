Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 15 Jul 2015 10:21:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bcm-kernel-feedback-list@broadcom.com"
	<bcm-kernel-feedback-list@broadcom.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jon Mason <jonmason@broadcom.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: Add Broadcom North Star 2 support
Message-ID: <20150715092101.GB9627@leverpostej>
References: <1436935343-4437-1-git-send-email-rjui@broadcom.com>
 <1436935343-4437-5-git-send-email-rjui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436935343-4437-5-git-send-email-rjui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +		bootargs = "earlycon=uart8250,mmio32,0x66130000";
> +	};

You shouldn't need those earlycon arguments if your driver has
of_earlycon support. If that's currently missing, could you add that
instead?

Thanks,
Mark.
