Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muin.pair.com ([209.68.1.55]:64778 "EHLO muin.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754625Ab3JABTH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Sep 2013 21:19:07 -0400
Received: from mail-ve0-f182.google.com (mail-ve0-f182.google.com [209.85.128.182])
	by muin.pair.com (Postfix) with ESMTPSA id CE6908FC3F
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2013 21:19:04 -0400 (EDT)
Received: by mail-ve0-f182.google.com with SMTP id oy12so4770132veb.13
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2013 18:19:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5248D94E.7080904@freescale.com>
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>
	<1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com>
	<CAOZdJXUF3ibW5iuB-2p5bhPp-Uw9MVKzqZiDdukMfi4f1d3Phw@mail.gmail.com>
	<5248D94E.7080904@freescale.com>
Date: Mon, 30 Sep 2013 20:19:04 -0500
Message-ID: <CAOZdJXUS4QEnKv1MNi=7CFgSGhkSE6hSb=T0xY5o4NqRdN-mjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with Layerscape
From: Timur Tabi <timur@tabi.org>
To: Lian Minghuan-b31939 <B31939@freescale.com>
Cc: Timur Tabi <timur@tabi.org>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Sep 29, 2013 at 8:52 PM, Lian Minghuan-b31939
<B31939@freescale.com> wrote:
>
> How about PCI_FSL_COMMON?

That's not any better.  The problem is that you have two symbols for
generic/common FSL PCI support.  Adding the word "common" does not
help.  You need to make the symbols distinct.  Either that, or merge
them into one symbol.
