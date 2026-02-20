Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE641C62;
	Fri, 20 Feb 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599682; cv=none; b=gSjLWnUjthETvsaDrb6+BW7AHfWLj2HfvNyJ647nLk6q6AwScdO7ZrNhNwlxVEaeEQaydknqJjhsT7gKj5y1a+xAK3Lr6AcjXswDlhnr15JEt0hTSZ7mo30JZDBKbscQXkeBJc9c9BxC7pXkSfpwZ47O6cW8268D8LFBkPLYEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599682; c=relaxed/simple;
	bh=geeZwow0omq4iGvEb9n1I0qYYor1p0V7EJ8MHKrdJPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C3whixp3BiBqPh5ONffqHxJYl1gtWtnjCY/D8PPLLg4PIEe9ePn6ac7ErFN/KpSt/ORMDdVmKHkd29LsAYMJpkM2ILGRimBE7P8VsBXI26kiFf6xLB42+M73cuyzkGiLm2JfukjVMZf8nJKEMAEEeGvs2cvsBabD/7LCp6+8W0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Geume5Rf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Geume5Rf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AACC116C6;
	Fri, 20 Feb 2026 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771599681;
	bh=geeZwow0omq4iGvEb9n1I0qYYor1p0V7EJ8MHKrdJPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Geume5RfRbfNtdFKyr3H80G0Bdl+KgYMXiMrRLqJMPo8nnPTnaKCapRcZjafwKOmc
	 p+OImXC/YPUrimJJuXbED7u1ZCn9DZp8H+l78xIUbfYzSfTNENeC5hO2nblL9tfb8O
	 nxlgZdYOePQWvKgSzgSXyP7A83BJ0oB0OCD9OqnNnCHgUAZ6FMVucQ7LJ5CpxSJfr+
	 j3bKhZOjlWt01J8ISU7C6Zt22W0plziWYNwCHKfuc1MqndTxu3tS+ymYPKMrrjKrYi
	 kteM5ZkXHX46asI0cBPNm98hQhQnjh/5XnjPuoDpmRSan2XRwQfH7q+KEh/B3kptCL
	 woJJyX60u4KKQ==
Date: Fri, 20 Feb 2026 09:01:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Steve Oswald <stevepeter.oswald@gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: Prevent shrinking bridge window from its
 required size
Message-ID: <20260220150120.GA3525869@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a425bb6-f08b-0aee-c494-843e42150a2f@linux.intel.com>

On Fri, Feb 20, 2026 at 01:32:43PM +0200, Ilpo Järvinen wrote:
> On Thu, 19 Feb 2026, Bjorn Helgaas wrote:
> ...

> > These both date back to v5.10 (Dec 2020), but Steve's report below is
> > only from Aug 2025, so I'm sort of assuming this is v7.1 material?
> 
> It's an old problem yes and impacts limited set of configurations
> (a device with big BARs attached to TB).
> 
> v7.1 is okay for me, this could cause some not immediately obvious problem 
> in some other case so it gives more time for us to hear about them 
> (hopefully).
> 
> > If we want it for v7.0, I'm going to need a CliffsNotes summary of the
> > commit log to justify it :)
> 
> Even if it's not going to be needed in this cases, what's "CliffsNotes 
> summary" ??

Slang for a short summary :)  I.e., a sentence or two to motivate a
pull request.  Big BARs attached via Thunderbolt sounds like an
important piece; e.g., maybe this helps fix Thunderbolt docks with
GPUs in them?
