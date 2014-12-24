Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:64223 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbaLXU34 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Dec 2014 15:29:56 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so7367047igi.12
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2014 12:29:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141224172646.GA19561@google.com>
References: <CAErSpo7pMAL5i2aPGV3u5F178bHeQTtjASckKs9NaUbEGaxv3Q@mail.gmail.com>
	<20141208233855.GA15713@shangw>
	<CAE9FiQXj-vX8TE-8Es83FmJAKDKD_dMNbQkmsaNPyy_nVEag8w@mail.gmail.com>
	<20141220002306.GB30834@google.com>
	<CAE9FiQUU4OoxpV3MNyFdjtmS1nRfD=ziYDDnUmsGy5qj8U3vLg@mail.gmail.com>
	<CAErSpo7JAcLa_2gNkOG+oSHb1cbBXdEa-TVW0=amBptRB8-fNA@mail.gmail.com>
	<CAE9FiQV6nxeMcLQ6YBR_c5tNGGjiKgL+Z4vcGpK21j-14V8SKw@mail.gmail.com>
	<CAE9FiQVggbU5u__0z8p33J9hQ39CtQ-vpQbZyjG-LO9aqN05Lw@mail.gmail.com>
	<20141223214106.GA27291@google.com>
	<CAE9FiQUoA_vz78sEnHtDAmzTJcwL0PdUe9jwLw+H9h3+omq+WA@mail.gmail.com>
	<20141224172646.GA19561@google.com>
Date: Wed, 24 Dec 2014 12:29:55 -0800
Message-ID: <CAE9FiQUCKVZN0rbvkBWTB_2w+=OrQFRWNkEbNCzH1j+hctqGFg@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Alex Deucher <alexdeucher@gmail.com>,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 24, 2014 at 9:26 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Dec 23, 2014 at 06:29:20PM -0800, Yinghai Lu wrote:
>
> OK, how about if we test it on x86, and if it works, you fix the other
> arches, and then I'll apply it for all arches at the same time?

Good to me.

>
> We are trying to fix a regression, but I don't think there's any reason to
> make the arches diverge for a relatively trivial change like this.

Sure.

Yinghai
