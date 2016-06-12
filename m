Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34992 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbcFLWmg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 12 Jun 2016 18:42:36 -0400
Received: by mail-qk0-f179.google.com with SMTP id c73so36767126qkg.2
        for <linux-pci@vger.kernel.org>; Sun, 12 Jun 2016 15:42:35 -0700 (PDT)
Date: Mon, 13 Jun 2016 01:42:28 +0300
From: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Kalle Valo <kvalo@codeaurora.org>,
	Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kozlov Sergey <serjk@netup.ru>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-pci@vger.kernel.org,
	kernel-mentors@selenic.com,
	Andrey Utkin <andrey_utkin@fastmail.com>
Subject: Re: [PATCH v2] Add tw5864 driver
Message-ID: <20160612224228.GA19711@zver>
References: <20160609221142.10139-1-andrey.utkin@corp.bluecherry.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160609221142.10139-1-andrey.utkin@corp.bluecherry.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update: added local change
 - to require fewer DMA buffers;
 - to require fewer vb2_queue buffers;
 - don't require vb2_queue buffers to be DMA-capable.
https://github.com/bluecherrydvr/linux/commit/410a86b08d230ff2a401ac9f5be3b30f8b29f30d
