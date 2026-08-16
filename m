Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC43C7DE8
	for <linux-pci@vger.kernel.org>; Sun, 16 Aug 2026 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913317; cv=none; b=UYIRZkOjEjZIsuK/1gB/EFKVuy7aZ26J8UgvMbeQs6VoQ3LMPRzNAQwvLONVPHd5zJjLj1/bNKidMypy3LIdJv89RtXgE4bk4LRwMT3B8F6e/VKZ954tQ+kN5MkzYr1DN2P9HMLss9KDLfkYx+PTG4sfQmJDwin8JJtbjVmq9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913317; c=relaxed/simple;
	bh=F5M3jEl2BKVUBh9dSKaLwyEDwQAKIXGUYZZ2lvSLOeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFGRqOWI4JEevYM//F4v+9zRQZPpXpp78OVxainIehyqNJaQX5JWkv3CkZRebu1t3if3+KLlwE0dDHwoDvBy+3F0w+14hviOBwTd+rd3ez8h6mszPPeCBSW5SxGY+Qi3DMhy6iIDf1rRP/fxL/m/Ri0vA0bqw5VuYaoqqNBVVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K8hujRqT; arc=none smtp.client-ip=91.218.175.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K8hujRqT"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F5M3jEl2BKVUBh9dSKaLwyEDwQAKIXGUYZZ2lvSLOeM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786913313; v=1; x=1787518113;
 b=K8hujRqTi8xNUCostiSMkGFhQguYRlyl+hZ1qwKekc9+ie6kd0FVGIIUIdkPCp8m8KK4cPxm
 kGpE6H5POxzVjjC0ZQZYQADLZ4iWGQ/OUdmB4J+Hhv0gduqYGYFXoZVwL/GY0Uwfn9LFIX5Lhgo
 N3+uHLmsRGXvaoO7bog0OTqk=
X-Envelope-To: linux-pci@vger.kernel.org
Received: from linux.dev (62.216.208.217)
	by mta11.migadu.com with ESMTPS id 7c857e761a9fa9d3;
	Sun, 16 Aug 2026 20:48:23 +0000
X-Migadu-Flow: FLOW_OUT
Date: Sun, 16 Aug 2026 22:48:17 +0200
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jesse Barnes <jbarnes@hobbes.lan>,
	Ingo Molnar <mingo@elte.hu>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Message-ID: <aoIiEZmqsOOwS6KX@linux.dev>
References: <20260807094601.263450-2-thorsten.blum@linux.dev>
 <aoFJwldO-_qttr0P@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoFJwldO-_qttr0P@wunner.de>

On Sun, Aug 16, 2026 at 07:25:22AM +0200, Lukas Wunner wrote:
> On Fri, Aug 07, 2026 at 11:46:02AM +0200, Thorsten Blum wrote:
> > early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> > returns nonzero, which avoids probing functions 1-7 on single-function
> > devices, but also stops scanning when a function is absent on a
> > multifunction device.
> > 
> > This can skip early quirks on multifunction devices with holes in their
> > function numbering.
> > 
> > Check function 0 first, and if it indicates a multifunction device, scan
> > functions 1-7 independently so that absent functions do not cause later
> > ones to be skipped.
> 
> Which device do you need this for?  We should only scan additional
> Functions if a quirk needs to applied to them because this extends
> boot time.  It requires a justification and shouldn't be done "just
> because".

On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
00:1c.3, also documented by the model list in abb2bafd295f ("x86/quirks:
Add early quirk to reset Apple AirPort card").

Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
is silently skipped on these machines.

[1] https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-imac-in-11-0/
[2] https://zoringroup.com/forum/5/7170/
