Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E431238C0A;
	Mon, 15 Jun 2026 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491238; cv=none; b=P9wk7Y4wCcWaJZhFdq8tI5q0+XdqGMgmGvOSX30nBcR+tyH5lV4Z73Dez0Mc8CHLQYK4ViSSAFxCygCx1OABHIq2ERT4HGy4dS8xkkDr052xaAJV5Dl9CeysDQb5Eu+L3VJGB86oJgAgfp9lptm9hPIsvqxnbOsnfL5YV6yb8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491238; c=relaxed/simple;
	bh=cFZ1RMreZvfQfrvQojsqOzBrVkK/dhrqYnY353EAW+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poDb3D+fd2gEz400yfLAQOnvu2Rx0f6nXGd8LxdRBlOWovg+YD0tySC9vsVYCltUSWiW+Mk3M5LhOW+x5htE5ZBEEb9l5lnH/mc7kdHFokVgQosOKyEusdjk0gMt/nrysMTJtSSRiNEcSo3na+5ilcgc+E03bKW/7oqaVtpRGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=epTzugAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="epTzugAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295001F000E9;
	Mon, 15 Jun 2026 02:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781491236;
	bh=MFM2GV/KQC+RCX2dTE8nz0VPfJDbQwI8pxfLack5p70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=epTzugAKQyJtXJZl0vMeovcDINeQhOF8q0KPBdQ5thq7bFhS1Kd2UUNCQ5hT5B7/N
	 jBIjejlZHHUnTaBoBGpJWE998ne8rxwmxqRNvQvr9wV97YxcU/nz5L45g/BS5fbe9L
	 wwOq9flFXKsl6mq8bd/L9/n7iiKqKqGVR6OleL0I=
Date: Mon, 15 Jun 2026 04:39:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	arnd@arndb.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-use-after-free in pci_endpoint_test_ioctl
Message-ID: <2026061553-fifty-qualified-2e04@gregkh>
References: <178144969601.60470.7358419009914000395@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178144969601.60470.7358419009914000395@gmail.com>

On Sun, Jun 14, 2026 at 06:16:39PM -0400, Shuangpeng Bai wrote:
> Hi Kernel Maintainers,
> 
> I hit the following report while testing current upstream kernel:
> 
> KASAN: slab-use-after-free in pci_endpoint_test_ioctl
> 
> I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
> 
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/1e03464adfefbb75fb5d8112691e38b3
> 
> I'm happy to test debug patches or provide additional information.

As we are drowning in real/fake/unknown bug reports, why not take the
time to work on a patch to fix these issues as you have a reproducer for
them?  That way you get full credit for the fix.

thanks,

greg k-h
