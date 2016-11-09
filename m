Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:58947 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753362AbcKINKL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2016 08:10:11 -0500
Date: Wed, 9 Nov 2016 14:11:15 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: "Levy, Amir (Jer)" <amir.jer.levy@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Jamet, Michael" <michael.jamet@intel.com>,
        "Alloun, Dan" <dan.alloun@intel.com>,
        "Westerberg, Mika" <mika.westerberg@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: Re: [PATCH 0/6] thunderbolt: Introducing Thunderbolt(TM) networking
Message-ID: <20161109131115.GA7401@wunner.de>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
 <20160524105506.GB5396@wunner.de>
 <E607265CB020454880711A6F96C05A0377FBD337@hasmsx107.ger.corp.intel.com>
 <CAMxnaaUz8nhqVc8ubaOVhSjkcwMUUYZjn5NvJ=mTkGk_SvD8Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMxnaaUz8nhqVc8ubaOVhSjkcwMUUYZjn5NvJ=mTkGk_SvD8Qg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 25, 2016 at 01:24:43AM +0200, Andreas Noever wrote:
> - Is it possible to use the ICM on Apple hardware?

Found this by accident:

On Macs introduced 2015 (MBP11,4, MBP11,5, MBP12,1, iMac17,1, ...)
the DSDT contains AML code which appears to enable ICM for
\_OSI("Windows 2012"), i.e. Windows 8 but not 7, presumably for BootCamp.

Grab an acpidump of an MBP11,4 here and search for ICM:
https://bugzilla.kernel.org/attachment.cgi?id=207701

There are two ICM-related GPEs, 0x10 and 0x14.

Best regards,

Lukas
