Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:55091 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757979Ab3DAOKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Apr 2013 10:10:01 -0400
Message-ID: <51599529.1070401@gentoo.org>
Date: Mon, 01 Apr 2013 17:09:45 +0300
From: Samuli Suominen <ssuominen@gentoo.org>
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: lspci -k is broken with depmod from kmod since it doesn't generate
 modules.pcimap anymore
References: <515213CF.7000804@gentoo.org> <CAErSpo5wG8FUyomySdze56-e9Jr+3DevoCGGAnhLM8vpOBvQ5w@mail.gmail.com> <CAMOw1v4jZXqT5Zm2ssSM8A2-ztQr1ovRi1BhQkbiCMoO3ss9Qg@mail.gmail.com> <CAPXgP13z3aoL+9zRpYnSkxYTdO6GFNgGRwaHbCAwFSRhnXtyjQ@mail.gmail.com> <mj+md-20130401.114439.12968.albireo@ucw.cz> <mj+md-20130401.134601.23475.albireo@ucw.cz>
In-Reply-To: <mj+md-20130401.134601.23475.albireo@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/04/13 16:46, Martin Mares wrote:
> Hello!
>
>> I'm looking into that. Expect a pciutils patch soon.
>
> Please check the current version in git://git.kernel.org/pub/scm/utils/pciutils/pciutils.git
>
> Looking up modules using libkmod should be fully supported.
>
> 				Have a nice fortnight
>

I spotted two possible problems with the commit

First, $PKG_CONFIG is not respected and call to pkg-config is hardcoded, 
this is likely to break cross-compiling

Since kmod is optional even in systemd source tree, and module loading 
is optional in the kernel, some embedded Linux users likely wants to 
enable/disable libkmod at will, for this there should be a ./configure 
flag of some sort

Thanks for your work!

- Samuli
