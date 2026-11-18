Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031200;
	b=OW27sdCFwjkfqJ/V/fONjufdiRj2JRBJtFIK6Vu2ZRnNpJrfdbp7V/oghsgK7JrfIOW7
	 O3PhADxQsUwSrww+EbGNRM+358+ckvRzyINGoIhj/K8k7JmAlcK6OKyQcOvg8GH/4wkVN
	 i8GXBwNnd06EEebGa5L3CuRWOVJ0N2M6Yeudzk07waYNtZnMyRKkl4/kSpXmTAChwzMxz
	 8QISwhhtUG6YqHplFTfWJeWOPjKqq9kq46RSt2rJUWBcM8WYPn1+8/WvgsljY2Acqo9Lo
	 BPeVjOry8E3MPnPPMfEj0+kIDl8xFjzEX5Ce8HxMix/NeWA0QqkTfAxCDsP69TwQhZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031200;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FraNARuPZ3tZqbt90b68MTJtjCSnJWUqeang1fd2yUA=;
	b=XKOVjIUbysbP3YieSDxJHkrXjY9UwPfEG/Zi6DnH7fu6H3ydBx0qiikUhAQWJVsWdYaL
	 uqb8XRnyvltCx//jjmAZYGpI9gfalO3qmXhZsv259P4HY/J4viEdiM9+/FYJgxuklIT15
	 CmRq5LSgunJfslJUEd3OBglr1GXDpK2hLmzyKtsN7B1yyi9xNQSEqdwsdsBzCBVEX1vcX
	 q+acBn6IMzMfdY0FG95l8qxMkIKx3iOlBRuLLv8b64teGMAeA7RJNRRAFnGfH4OSl7xfx
	 T8RdLhEjJjQSQSSUfdomzjxzScmt1QvjXyuB2INVK5q9N9/UE3Twtw7LRWq3aG0zkaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8rhOii4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC1606A33A;
	Wed, 18 Nov 2026 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8rhOii4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C5E1F000C6;
	Wed, 18 Nov 2026 19:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031200;
	bh=FraNARuPZ3tZqbt90b68MTJtjCSnJWUqeang1fd2yUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k8rhOii4GBidYBHAj6OybYKjTi95/OE4IutpnAuro0koyhgtSDGMrHBqjxr2sRagl
	 xsXin4sy87M6WN68cIHkqd3YIiqDzzLGmqRMy0dAcmgLOjmMTijhTQf7Uj4/jUmVrN
	 lwFMRFnl/uAjRVANuBcqyW7GFSh2cKjw7odg8pFJGFKroRsjqyyWye4YpEJ5E5X0mu
	 SpQubNXz2Pii6uA+K9BywHWQWqD72reCnZILizmgwg+ld1G//C9l325rWrKrAVwdna
	 pRjtmXTtrY8/Az4tAbLk4ZVbgV2OY6SA2/k3co8e/Kq7g+ymgLGiZqR4I0uKOjOlcP
	 screbGc9dWcmw==
Date: Wed, 18 Nov 2026 19:46:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Hanjun Guo
 <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai
 Xue <xueshuai@linux.alibaba.com>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Pawel Chmielewski
 <pawel.chmielewski@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Dave Jiang <dave.jiang@intel.com>, "Fabio M. De Francesco"
 <fabio.m.de.francesco@linux.intel.com>, Breno Leitao <leitao@debian.org>,
 Terry Bowman <terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Williams
 <djbw@kernel.org>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
Subject: Re: [PATCH v1 10/19] ACPI: extlog: Simplify fatal record printing
Message-ID: <20261118194628.30ad2621@jic23-hlaptop>
In-Reply-To: <20261117111444.4185512-11-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
	<20261117111444.4185512-11-pierre.gondois@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 12:10:20 +0100
Pierre Gondois <pierre.gondois@arm.com> wrote:

> Only fatal CPER records reach print_extlog_rcd().

Maybe mention that is only true due to an earlier patch
(just refer to it by title). This kind of reads like
it has been true for ages and you are just tidying it up.

> Merge the two helpers, remove the unused prefix argument
> and return value, and keep a single rate limiter.

I love the trivial sometimes.  Short wrap.  Go to 75ish chars.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
With any background you can add (or none if it seems it was never
any different). 

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

