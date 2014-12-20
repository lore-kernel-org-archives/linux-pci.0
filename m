Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:63404 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbaLTBdO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Dec 2014 20:33:14 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so13940iec.23
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2014 17:33:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7JAcLa_2gNkOG+oSHb1cbBXdEa-TVW0=amBptRB8-fNA@mail.gmail.com>
References: <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
	<20141204173411.GA5949@google.com>
	<CAE9FiQVyBmo+XwDgO97wwe+6TN4+q_cvnBLCuhTM8Fu_e_V5RQ@mail.gmail.com>
	<1417777177.4741.69.camel@kernel.crashing.org>
	<20141208004735.GA15508@shangw>
	<CAErSpo69c6jXOp+nw2sTSU4vgqGufUQNUEGK4_2+6p-qpyE0vQ@mail.gmail.com>
	<1418074683.13358.1.camel@kernel.crashing.org>
	<CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
	<20141208233855.GA15713@shangw>
	<CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
	<20141220002306.GB30834@google.com>
	<CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
	<CAErSpo7JAcLa_2gNkOG+oSHb1cbBXdEa-TVW0=amBptRB8-fNA@mail.gmail.com>
Date: Fri, 19 Dec 2014 17:33:13 -0800
Message-ID: <CAE9FiQV6nxeMcLQ6YBR_c5tNGGjiKgL+Z4vcGpK21j-14V8SKw@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 19, 2014 at 4:56 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> Marek's case is a little easier because his system is using _CRS.  We
> should be able to notice that the Root Port window overlaps the host
> bridge window, but isn't contained by it.  In that case, if we merely
> trim the Root Port window so it fits, everything will just work.

Ok, will check that Monday.

Yinghai
