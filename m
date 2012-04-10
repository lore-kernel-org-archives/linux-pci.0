Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:58830 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754155Ab2DJR3z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2012 13:29:55 -0400
Message-ID: <4F846E01.2090103@snewbury.org.uk>
Date: Tue, 10 Apr 2012 18:29:37 +0100
From: Steven Newbury <steve@snewbury.org.uk>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resources above 4GB
References: <1333968563.5678.19.camel@infinity> <CAErSpo7hGvJSmq4U37XN9T7ZaYn55fyy9t3ER5BBCDdQ3XZxqw@mail.gmail.com> <4F84110E.3000400@snewbury.org.uk> <CAE9FiQVHf_pcXUspOtLXx4XminmzdWja3Ra2Wh5jQRbfNOQ1eQ@mail.gmail.com> <4F8467AA.90305@snewbury.org.uk>
In-Reply-To: <4F8467AA.90305@snewbury.org.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/04/12 18:02, Steven Newbury wrote:
> 
...
> 
> So far it has changed behaviour:
> 
> Many devices now assigned above 4g.
Looking more carefully, several of the PCI bridges have "Prefetchable
memory behind bridge" >4gb, but I don't see any "devices".
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+EbgEACgkQGcb56gMuC63gLQCgwUTHdDqPTugqeVC1cXWhCQJH
IaEAoK+A1B035nC0GKi2Y55OtVEOYQXN
=JoAF
-----END PGP SIGNATURE-----
