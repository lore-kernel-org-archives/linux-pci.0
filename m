Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2383D45E7;
	Tue, 28 Jul 2026 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265800; cv=none; b=oEj6xXI5+jcpkft14iyLtsCkIEwIVHZazaiVXmCCISx7ghB4g4hCFV2bCKQ/WfpmvF4kbBHv7iiM65VncKTX5dXjVg2kN1sFCWBrWMvYhLYRZpCyw/X/RQie7Yn7nD4Wf8YPvvg/o0+ZS1sHJEGyCJ8D9+38RtD0k7XVDPlYoy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265800; c=relaxed/simple;
	bh=hE9wUFkt5eDNkvvQtk/2Iu176NwOzqh45u5idWuIhRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LaTa6miAzlBbSpHLMlmmH09eWcnULjLSxTKVOWOPNf+C6hGhFRx3mfAJzuJ/z18hmf40gZnF6+ZvgC6VltaSwYTdpMWTVW/7kSsbVLWWhWeC0uFjuwMrUuwYISyiCpqZnL2hItxPZ9WsB37Xe51AwmJypAuWhCR9VQcfn6ejgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMzAWBJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMzAWBJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBA41F000E9;
	Tue, 28 Jul 2026 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785265796;
	bh=TJD91TM746oqHIyvwmlpml5A1+necmAOpkMxxCm3JHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mMzAWBJArOPMxc0+2VqRNQKaQsKIx3TkBYa833wWFEV6lVwtn5yHZXE4lhMAEYKSZ
	 OaEDnUU5wQzmGemrquzCyuYqyKy2H7HlQFjMNGplBaDyOl4vjhr2tCnbS8K417AU+O
	 qjIbvrsfxKBry25K7QLyp6+Bj9iBuGsN5P/nX1AdlUBQeM/1knHHkZQidmIrtCJwwz
	 x9v8LweZBVGV8L2UbokRYoy3jTurOqGWQ0c9d426pSQkpO8jod4jkkSPMRh5Q0mstL
	 GYwGMoFGfKICURqiH/c2asi9Jh1arJqdah/jyZgD3qtAzg+fhYX89DqzF90zcHN50L
	 0qDW21jbOmaqQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: syzbot <syzbot+690d666eb12fca6e1e61@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Danilo
 Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 driver-core@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [syzbot] [kernel?] WARNING: proc registration bug in
 unregister_irq_proc (2)
In-Reply-To: <2026072703-sandbox-oven-5235@gregkh>
References: <6a653bcf.073198cf.94f0f.001c.GAE@google.com>
 <87ik60ikal.ffs@fw13> <2026072703-sandbox-oven-5235@gregkh>
Date: Tue, 28 Jul 2026 21:09:53 +0200
Message-ID: <87qzkngcce.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 27 2026 at 16:33, Greg Kroah-Hartman wrote:
> On Mon, Jul 27, 2026 at 04:22:58PM +0200, Thomas Gleixner wrote:
>> I rather go and harden the interrupt core against such bogosities.
>
> Sure, but really, anyone doing a manual "unbind" gets to keep the pieces
> if the kernel can't handle it. The comedi driver really aren't all that
> ready for stuff like this as they are in systems that are fixed to the
> shop floor, driving big stone cutters.
>
> So no real rush/need that I can see here.

I understand, but it bothers me that the leakage is detected way too
late and only unearthed by removing a proc entry. There might be actual
references dangling. The interrupt core code knows all that at the point
where the teardown starts and that's where it can cleanup the mess and
emit a warning message.

Thanks,

        tglx
