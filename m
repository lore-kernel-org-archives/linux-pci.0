Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:36128 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273Ab3AOHos (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jan 2013 02:44:48 -0500
Received: by mail-bk0-f44.google.com with SMTP id w11so2389403bku.17
        for <linux-pci@vger.kernel.org>; Mon, 14 Jan 2013 23:44:47 -0800 (PST)
From: bl0 <bl0-052@playker.info>
To: linux-ide@vger.kernel.org
Subject: Re: sata_sil data corruption, possible workarounds
Date: Tue, 15 Jan 2013 08:44:22 +0100
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <kernel@teksavvy.com>,
	Tejun Heo <tj@kernel.org>,
	Robert Hancock <hancockrwd@gmail.com>,
	linux-pci@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
References: <kahap3$mur$1@ger.gmane.org> <50F0199D.4090502@teksavvy.com> <50F4475F.9000509@pobox.com>
In-Reply-To: <50F4475F.9000509@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201301150844.22693.bl0-052@playker.info>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 14 January 2013 18:58:55 Jeff Garzik wrote:
> If the issue continues to be seen, 

You mean, more than it has been seen already?

> a knob to enable an ugly solution is 
> better than nothing, from the user's perspective.

Also, I fail to see how this is any more ugly than what the current code 
does.
