Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:32800 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbcGaSpR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jul 2016 14:45:17 -0400
Date: Sun, 31 Jul 2016 11:45:13 -0700 (PDT)
Message-Id: <20160731.114513.2022660088754330528.davem@davemloft.net>
To: amir.jer.levy@intel.com
Cc: stephen@networkplumber.org, andreas.noever@gmail.com,
	gregkh@linuxfoundation.org, bhelgaas@google.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	thunderbolt-linux@intel.com, mika.westerberg@intel.com,
	tomas.winkler@intel.com
Subject: Re: [PATCH v5 6/8] thunderbolt: Networking transmit and receive
From: David Miller <davem@davemloft.net>
In-Reply-To: <E607265CB020454880711A6F96C05A039710868B@hasmsx108.ger.corp.intel.com>
References: <1469693721-5641-7-git-send-email-amir.jer.levy@intel.com>
	<20160729140741.18ca3e35@xeon-e3>
	<E607265CB020454880711A6F96C05A039710868B@hasmsx108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Levy, Amir (Jer)" <amir.jer.levy@intel.com>
Date: Sun, 31 Jul 2016 10:15:52 +0000

> The network stack thinks it is Ethernet, it might not accept Runt
> frames, so the driver pads the frame in receive.

The network stack doesn't care about this at all.  It's wasted effort
on your part.

