Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34834 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbbJGJQH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 05:16:07 -0400
Received: by igbkq10 with SMTP id kq10so103931024igb.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Oct 2015 02:16:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKsTQnne+knY2owNTYVG9hL93fDSwKK2TRQ8sp-zgjJD2qZ_ng@mail.gmail.com>
References: <1443810216-3215-1-git-send-email-netwerkforens@gmail.com>
	<20151003143056.GA17684@localhost>
	<mj+md-20151005.101820.16366.nikam@ucw.cz>
	<CAKsTQn=GEJwk-OFypdVLFQcXrYy4Zc8ADgX6V=rX0azfQspjkg@mail.gmail.com>
	<CAKsTQnne+knY2owNTYVG9hL93fDSwKK2TRQ8sp-zgjJD2qZ_ng@mail.gmail.com>
Date: Wed, 7 Oct 2015 11:16:06 +0200
Message-ID: <CAKsTQn=bM3tE0e4RWsMjj0qHJWEo_jZaMhfTAcng8QrT8yChGg@mail.gmail.com>
Subject: Re: [PATCH] Enumerate all undiscovered PCIe busses
From: Ruud <netwerkforens@gmail.com>
To: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As alternative I made another patch that allows to specify a specific
busnumber as a base:

https://github.com/netwerkforens/pciutils/tree/multibus_v2
https://github.com/pciutils/pciutils/pull/2


>> It is not a problem for me to use a patched version of pciutils
>> locally, but hoped to share. Perhaps as an idea: make the base
>> bus-number configurable at the command line instead of hard coded?
>>
