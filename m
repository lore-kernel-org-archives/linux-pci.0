Return-Path: <SRS0=E3+c=YM=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=E3+c=YM=quantumtechnology.info=kilian.singer@kernel.org>
Date: Fri, 30 Dec 2016 00:02:36 +0100 (CET)
From: Kilian Singer <kilian.singer@quantumtechnology.info>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-ID: <2012792022.490.1483052556774.JavaMail.zimbra@quantumtechnology.info>
In-Reply-To: <2083249365.479.1483051950725.JavaMail.zimbra@quantumtechnology.info>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <20161228112954.GA17925@wunner.de> <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com> <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info> <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info> <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info> <20161229175028.GA18510@wunner.de> <2083249365.479.1483051950725.JavaMail.zimbra@quantumtechnology.info>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

The patch failes on 2 insert points, but I applied it by hand.
Should I use another repo or commit?

I also patched the Makefile due to the some gcc issues:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=841420
I guess that does not matter.
