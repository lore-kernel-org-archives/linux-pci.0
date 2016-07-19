Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay0064.hostedemail.com ([216.40.44.64]:54381 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753022AbcGSROK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2016 13:14:10 -0400
Message-ID: <1468948445.1900.53.camel@perches.com>
Subject: Re: [PATCH v4 0/7] thunderbolt: Introducing Thunderbolt(TM)
 networking
From: Joe Perches <joe@perches.com>
To: Amir Levy <amir.jer.levy@intel.com>, andreas.noever@gmail.com,
	gregkh@linuxfoundation.org, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, thunderbolt-linux@intel.com,
	mika.westerberg@intel.com, tomas.winkler@intel.com
Date: Tue, 19 Jul 2016 10:14:05 -0700
In-Reply-To: <1468836040-28043-1-git-send-email-amir.jer.levy@intel.com>
References: <1468836040-28043-1-git-send-email-amir.jer.levy@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2016-07-18 at 13:00 +0300, Amir Levy wrote:
> This is version 4 of Thunderbolt(TM) driver for non-Apple hardware.
[]
>  Documentation/00-INDEX                   |    2 +
>  Documentation/thunderbolt-networking.txt |  135 ++
>  drivers/thunderbolt/Kconfig              |   25 +-
>  drivers/thunderbolt/Makefile             |    3 +-
>  drivers/thunderbolt/icm/Makefile         |   28 +
>  drivers/thunderbolt/icm/icm_nhi.c        | 1642 +++++++++++++++++++++
>  drivers/thunderbolt/icm/icm_nhi.h        |   93 ++
>  drivers/thunderbolt/icm/net.c            | 2276 ++++++++++++++++++++++++++++++
>  drivers/thunderbolt/icm/net.h            |  274 ++++
>  drivers/thunderbolt/nhi_regs.h           |  115 +-
>  10 files changed, 4585 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/thunderbolt-networking.txt
>  create mode 100644 drivers/thunderbolt/icm/Makefile
>  create mode 100644 drivers/thunderbolt/icm/icm_nhi.c
>  create mode 100644 drivers/thunderbolt/icm/icm_nhi.h
>  create mode 100644 drivers/thunderbolt/icm/net.c
>  create mode 100644 drivers/thunderbolt/icm/net.h

Is a MAINTAINERS update necessary or is Andreas going to
be the maintainer?
