Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59602 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349Ab1LEPPe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 10:15:34 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] lib/devres.c: allow specifying NO_IOPORT while using PCI
Date: Mon, 5 Dec 2011 15:14:02 +0000
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Maxin B. John" <maxin.john@gmail.com>, Tejun Heo <tj@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Paul Mundt <lethal@linux-sh.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"David S. Miller" <davem@davemloft.net>,
	Al Viro <viro@zeniv.linux.org.uk>
References: <cover.1322592494.git.mst@redhat.com> <1616727.0BYPKXtoA0@wuerfel> <4ED91D95.6040601@tilera.com>
In-Reply-To: <4ED91D95.6040601@tilera.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201112051514.02360.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 02 December 2011, Chris Metcalf wrote:
> The specific issue I saw was calls to pcim_iomap_{regions,table} from
> drivers/ata/libata-sff.c and drivers/ata/sata_sil24.c; we use the
> sata_sil24 in one of our platforms (TILEmpower).

Hmm, so sata_sil24 does not actually use PIO, so we can probably find a
way to make that work. Why do you have to build libata-sff? Shouldn't
that only be needed if you actually have an sff-type controller?

	Arnd
