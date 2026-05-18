Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0332B4921AA;
	Mon, 18 May 2026 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120585; cv=none; b=luhH/tanLhVv8MX3HNwNi6tkiCX4FUnYSWCyHFcY6Afz7pqhoTJFzs8nFZwmFY2C2PANUfUme5iDRE0c7GwiXzShTQEmUtz7LTwFuB4ZO7xxAgRYWf3VGS+CDvj0HTZVfOh/uPAzFuPXlKbNDV6cSX9/m+sSW6G9MmgWH8CJZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120585; c=relaxed/simple;
	bh=s7bf1gytuPn56xayEzHgxmKGWQoeuGExmsjfzDxy83E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLppf2ZI5OUdE4bw91CBCmrTLC4/un9bdvGXemgAMfuWeS31IlL2uLYUgCcH0drHJnvU7q+Ef83crGMn/herRn02m1zdStJrSxdtGHswILVGOwbKyEHbMB5hbqH4OM1mkabe0hIqqqQgeWE7sgDUcr1xyE/Jak+P+9XuSB8L/uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1kOa37c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1kOa37c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A021EC2BCB8;
	Mon, 18 May 2026 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779120581;
	bh=s7bf1gytuPn56xayEzHgxmKGWQoeuGExmsjfzDxy83E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E1kOa37cr7bPE9swjgFFgtDKCM5l/qpuwM4pboIejehjvUZ2WUbDVb+k7AFQ5Hry8
	 Lji4+Ka09N4UVUj/nNgZGHqrRnL7gU1YHHMkgodhyBDFjHjueJ1xripfcXawy6uGcN
	 af0PChBPfRexi05qgulxWbVpITsvjBYsb2eJsHEje2Ps6pUXVumyWDsKnvxafZLJNT
	 7EYPNsgwVCJpuqhtmlJ6Zamo46eCzrSDFRNYqwcKuVqNkVniC5xylD6aMsksiKn+Yg
	 bt8MHAJkKPgRJ1eqbIa/IYe0/kdgTIF6nhlQfEa/m+iBRxYIrjm1zcwVFVr5JBh/iw
	 CFH8fkI66NCoQ==
Date: Mon, 18 May 2026 17:09:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: "Bowman, Terry" <terry.bowman@amd.com>, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, vishal.l.verma@intel.com,
 alucerop@amd.com, ira.weiny@intel.com, corbet@lwn.net, rafael@kernel.org,
 xueshuai@linux.alibaba.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v17 02/11] cxl/ras: Unify Endpoint and Port AER trace
 events
Message-ID: <20260518170927.2ffa8211@jic23-huawei>
In-Reply-To: <69feaebd471c3_1b86a100b@djbw-dev.notmuch>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
	<20260505173029.2718246-3-terry.bowman@amd.com>
	<20260507190836.70197e24@jic23-huawei>
	<8913c666-a343-4717-8ab2-0b8546d1bdfb@amd.com>
	<20260508150533.04e19cf9@jic23-huawei>
	<69feaebd471c3_1b86a100b@djbw-dev.notmuch>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 20:49:17 -0700
"Dan Williams (nvidia)" <djbw@kernel.org> wrote:

> Jonathan Cameron wrote:
> > On Thu, 7 May 2026 13:33:45 -0500
> > "Bowman, Terry" <terry.bowman@amd.com> wrote:  
> [..]
> > > > This concerns me (sorry I wasn't paying attention to the v16 thread).
> > > > It is a userspace regression against code that is out in the wild and typically
> > > > not updated in sync with the kernel.
> > > > 
> > > > If you are suggesting breaking ras-daemon at the very least +CC the maintainer.  
> 
> Sorry, that was not the intent, see below.


Sorry for slow reply - getting a bit buried in other kernel work so haven't been
checking CXL stuff as often as normal.

Anyhow direction looks good to me.

Jonathan

