Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:55194 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423570Ab2LFQIa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2012 11:08:30 -0500
Date: Thu, 6 Dec 2012 17:08:27 +0100
From: Martin Mares <mj@ucw.cz>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: pciutils pci_open seg with invalid arg to -i
Message-ID: <mj+md-20121206.160703.2718.nikam@ucw.cz>
References: <20121204142008.GB6117@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121204142008.GB6117@gallifrey>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi!

> So I was going to suggest something like:
> 
>  33   if (len < 3 || memcmp(a->id_file_name + len - 3, ".gz", 3) != 0)
>  34     return result;

Yes, that's right.

Please try the current version in the Git repository, it's fixed there.

> which would mean that it would drop out if it was a short filename; but
> then I started to try and understand the code more; it looks to me like:
> 
>    try and gzopen it.
>    if that fails
>      check it ended with a .gz (else fail)
>      strip the .gz off the end
>      gzopen it without the .gz
> 
> But why bother?  According to the zlib manual for gzopen :
>   ( http://www.zlib.net/manual.html )
>      
> ' gzopen can be used to read a file which is not in gzip format; in this case
> gzread will directly read from the file without decompression. When reading,
> this will be detected automatically by looking for the magic two-byte gzip
> header. '
> 
> So what are lines 32-39 trying to do?

When somebody specifies a file name like "pci.ids.gz" (or it's the default name)
and no such file exists, it tries the same name without ".gz".

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Weather forecast for tonight: dark.
