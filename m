Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Mar 2013 09:30:27 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] PCI: Introduce MSI chip infrastructure
Message-ID: <20130322093027.GA521@arm.com>
References: <1363942307-9327-1-git-send-email-thierry.reding@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1363942307-9327-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 22, 2013 at 08:51:45AM +0000, Thierry Reding wrote:
> It
> is the responsibility of the PCI host bridge driver to setup the MSI
> chip for the root bus.

I think this could work well. In the future if the use of an independent MSI
controller is required, then new DT bindings for host-bridges could use
phandles to reference independent MSI controllers as their providers of
MSIs. I guess this functionality can be built on top of what you have proposed
later as the need arises.

Andrew Murray
