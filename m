Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59514 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424199AbcFMU61 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 16:58:27 -0400
Date: Mon, 13 Jun 2016 15:58:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
Message-ID: <20160613205823.GA18747@localhost>
References: <cover.1463134231.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 13, 2016 at 01:15:31PM +0200, Lukas Wunner wrote:
> This series powers Thunderbolt controllers on Macs down when nothing is
> plugged in, saving 1.7 W on machines with a Light Ridge controller and
> reportedly 4 W on Cactus Ridge 4C and Falcon Ridge 4C.

Hi Lukas,

I suppose these depend on Mika's runtime PM patches (at least, I see
Mika's commits in your github tree).  Would you mind rebasing your
patches so they apply on my pci/pm branch?  I couldn't import them
directly into stg.

I'm sure git could pull them in easily, but I use git in a very
simple-minded way.

Bjorn
