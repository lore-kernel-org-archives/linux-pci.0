Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A93254B18;
	Mon, 20 Jul 2026 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591598; cv=none; b=rOVjtVhSvQZFv3sIbweXMt/I9aJQj5gQ+/qn0T3eGu8/zVpVdpJqlM5+aiuNi+zHTd3cgVADOwJlEHyuOL7y4KWmA5ThtJ2X1hnPssMPxDMBlmktVzi8WVnVhtrFRccAPI52pPOMn818ZvAcRhLIPx0CfUU4jr7PvETI+W1FGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591598; c=relaxed/simple;
	bh=q7fjk7ySe8tMF07ls7domV896YuN1gswx9g3SDXon0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D48dhMI3Y2WBs+rqveL6w8HffuZeMGkO0QjN1i2X1HKLOoe3mi8GbFcrxUyL8j04moMuKfVvugjv0dLZjtER6RTf7plB5jX3024kt0p+FNc9aKKJI0rfHQIIa9on+XBz1mxxWb67T11PtJgQVYB1ToggFepa77/D7GgiucmkqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWdKjHHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWdKjHHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754791F000E9;
	Mon, 20 Jul 2026 23:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784591597;
	bh=BLhnvNf/85wnLfb3go4qsPaXWY4wivWkwsn6ENwE/jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kWdKjHHLsYpoKqztUqo2WzOLH9eaXTzckUcKGa+/i6JG0cCc9xiRm4RjZDIZyX9Fj
	 pqrdE17arKn//rs/bsKFPTlybjbIgX5J9Ds6tT/O4suhhLIbmZ0O59Q07LgZQm8CzQ
	 RgYon6gPPPpC+Cq2x6epFd70I3qHL4iJ46sPk/oDkpYcHJkQIy5n4r8zodY+LKFXQy
	 14AytinsWs71fKBUvacfL35gUGGFHjLERjTbc1DtUNfCIRP/IaKDllh7cHE1s14UwE
	 +gsnWFYr3GSsynXhk6ezwgKJB5TaS4AJJIezEtJ9dSZHykSGBS9K/Bfhl8yB4+pm2N
	 ckRpn0HwMjH1Q==
Date: Tue, 21 Jul 2026 00:53:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v18 10/13] cxl: Add port and dport identifiers to CXL
 AER trace events
Message-ID: <20260721005312.3c0bb10e@jic23-huawei>
In-Reply-To: <75709fbe-3825-45ea-9a98-884b31430eb6@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-11-terry.bowman@amd.com>
	<20260717225316.02D321F000E9@smtp.kernel.org>
	<75709fbe-3825-45ea-9a98-884b31430eb6@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 10:14:27 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 7/17/2026 5:53 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [High] Asynchronous CPER error handling races with ACPI driver unbind, causing Use-After-Free of cxl_dport.  
> This is a false positive.
> 
> The Downstream port lifecycle is tied to the Port's xarray and synchronized here using the 
> Port's device lock.
> 
> > - [High] Live PCI configuration space reads on a potentially frozen or dead link during AER recovery.  
> This is fixed in patch 11 with introduction of cached PCI DSN.
Why not flip the patch order?

