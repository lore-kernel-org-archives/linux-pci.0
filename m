Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62655 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806Ab3CYJaE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2013 05:30:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [RFC 0/2] PCI: Introduce MSI chip infrastructure
Date: Mon, 25 Mar 2013 09:29:57 +0000
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1363942307-9327-1-git-send-email-thierry.reding@avionic-design.de> <20130325093847.7474dc0e@skate> <20130325091534.GA21054@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130325091534.GA21054@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201303250929.58010.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 25 March 2013, Thierry Reding wrote:
> I think you can just make this:
> 
>         mpic: interrupt-controller@d0020000 {
>                 ...
>         };
> 
>         ...
> 
>         soc {
>                 pcie-controller {
>                         marvell,msi = <&mpic>;
>                 };
>         };
> 
> And everything else should just work given the APIs I mentioned. But as
> you said it'd be good if somebody else could share their opinion about
> this.


I think the property referring to the msi controller should have a fixed
name, such as "msi-parent", to go along with "interrupt-parent".
Similarly, I would suggest using an empty "msi-controller" property
to mark the controller that is capable of serving MSIs. The Linux
implementation doesn't currently require the "interrupt-controller"
property, but I think it's good to stay close to the original interrupt
binding here for consistency.

	Arnd
