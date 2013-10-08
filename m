Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48395 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755341Ab3JHXbp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Oct 2013 19:31:45 -0400
Message-ID: <1381275075.645.251.camel@pasglop>
Subject: Re: [PATCH 1/2][v2] pci: fsl: derive the common PCI driver to
 drivers/pci/host
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
Date: Wed, 09 Oct 2013 10:31:15 +1100
In-Reply-To: <1381274440.7979.309.camel@snotra.buserror.net>
References: <1380531175-14836-1-git-send-email-Minghuan.Lian@freescale.com>
	 <CAErSpo7LXqXmrw1gPwKHsJkKaAcDr2W_+tcC8b9T_5Mab1Arnw@mail.gmail.com>
	 <1381272382.7979.292.camel@snotra.buserror.net>
	 <CAErSpo76_w+wK76m73kkdYS1PouhYcGfZus_FYF5E2FHJTA6gQ@mail.gmail.com>
	 <1381274440.7979.309.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-10-08 at 18:20 -0500, Scott Wood wrote:
> > So I'll apply these given an ack from the powerpc folks.
> 
> ACK this patch.  The second one I'd like to see broken up into
> digestible chunks so I can better review it.

Bjorn, for such FSL-only stuff, Scott ack is enough, don't wait for
mine :-)

Cheers,
Ben.


