Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29697364E84;
	Wed, 20 May 2026 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266628; cv=none; b=VJW7vjFppNT4PuXSoWd+I3QbmwXn5uwmmoRTynpHf89KzotSiiniYza+h9Hj6KiWC4TlN3pnxOqJu8754aeS0XvI8Lq0r6yb5b/VToyUeVkyNV+jItiZOQjS2UU+P0jQya/3DCcx7Ctm+47rFl/jSWjLdCiPkCcdvQo0cH7w4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266628; c=relaxed/simple;
	bh=yMwsNQMj4Svr/p/gzC5GK4l+6DDaLa2WkRyWtWW/OCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffkVMH89RzKMLz+fra9nqe+YNC49qEvWS7PfsO9Jist7BhZnfRPa+IeSj6vK2A0i8nrw4n4oHtNjpQhsFvIky6AvwaFIztZdfwLZEX02+YEX+tGmhh4YgXgZlFx8gRLI0cxXnvZs5qWNhb7WF8JWJKnV/euGSa233A0KWSneHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 4A3BB10625;
	Wed, 20 May 2026 10:43:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 38FD1602E4CC; Wed, 20 May 2026 10:43:36 +0200 (CEST)
Date: Wed, 20 May 2026 10:43:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Yury M." <yurypm@arista.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
Message-ID: <ag10ON5pZ4ymPT9U@wunner.de>
References: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
 <agwzHzF3bpPM6jcC@wunner.de>
 <3633b587-5782-4cfa-b967-997de86866bb@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3633b587-5782-4cfa-b967-997de86866bb@arista.com>

On Tue, May 19, 2026 at 05:05:20PM +0100, Yury M. wrote:
> Root port can detect AER error with source 0000:00:00.0.
> 
> In this case, we call find_source_device -> find_device_iter. The
> 'multi-error' flag is not set, and we are looking for the first error (not
> all). This means that for any error with the 0000:00:00.0 source on the root
> port, we will report the error for the first device on the bus.

No, is_error_source() considers bus number 0 as a bogus number
and will iterate over all devices on the bus.

> In my case, an AER error reported by 0000:06:08.0 will be logged as an error
> reported by 0000:06:07.0 if AER recovery constantly fails.

The problem is that 0000:06:08.0 reports an Advisory Non-Fatal Error,
i.e. it sets the ANFE bit in the Correctable Error Status Register
and signals (only) a Correctable Error, even though it also sets bits
in the Uncorrectable Error Status Register.

The kernel lacks support for ANFE handling and will only clear the bits
in the Correctable Error Status Register.  It neglects to also clear
(and report) the bits in the Uncorrectable Error Status Register.

There was an effort two years back to bring up ANFE support but it
fizzled out.  I talked to the submitter and he's now busy with other
things:

https://lore.kernel.org/r/20240620025857.206647-1-zhenzhong.duan@intel.com/

It's on my todo list to respin his series but I can't promise when
I'll get to it.

Thanks,

Lukas
