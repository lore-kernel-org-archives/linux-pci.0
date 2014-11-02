Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:56718 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbaKBLOn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Nov 2014 06:14:43 -0500
Received: from albireo.burrow.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 565171C0141
	for <linux-pci@vger.kernel.org>; Sun,  2 Nov 2014 12:14:42 +0100 (CET)
Date: Sun, 2 Nov 2014 12:14:41 +0100
From: Martin Mares <mj@ucw.cz>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] lspci: Add ability to filter by class code
Message-ID: <mj+md-20141102.111418.11691.albireo@ucw.cz>
References: <1412099436-18899-1-git-send-email-matthew.r.wilcox@intel.com>
 <20140930180252.GD5098@wil.cx>
 <mj+md-20141101.161931.20316.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <mj+md-20141101.161931.20316.albireo@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello!

>   •  Extending struct pci_filter breaks ABI (my fault in designing
>      the API years ago -- it would have been much better if the struct
>      were allocated by the library instead of the caller). Could you
>      please add symbol versioning for pci_filter_(init|match|parse_id)?

Done. It was somewhat tricky, but it should work.

					Martin
