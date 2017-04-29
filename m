Return-Path: <SRS0=xmg3=4F=ucw.cz=mj+f-290417+helgaas=kernel.org@kernel.org>
Return-Path: <SRS0=xmg3=4F=ucw.cz=mj+f-290417+helgaas=kernel.org@kernel.org>
Date: Sat, 29 Apr 2017 20:12:27 +0200
From: Martin Mares <mj@ucw.cz>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Jayachandran C <jnair@caviumnetworks.com>
Subject: Re: [PATCH 0/9] lspci: AER, PCIe capability updates
Message-ID: <mj+md-20170429.181217.38633.nikam@ucw.cz>
References: <20170421192844.6562.30976.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170421192844.6562.30976.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi!

> These are some updates to decode more AER registers, decode "Slot
> Implemented" for reverse bridges, and drop ASPM exit latencies for
> unsupported states.  And a few more cosmetic whitespace, spelling, etc.,
> fixes.

Thanks, all applied.

				Martin
