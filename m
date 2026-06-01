Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3EA385D89;
	Mon,  1 Jun 2026 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302014; cv=none; b=VneN6ghzWGFv0y6/dTHVrLY2I/S4XkewoN2M0zBot3CTj38etmAB15Av1i5Ni2+/Ats2wXwvpk/KpLnx7sqylWFRfB+r9XUSHkvmsDir9qZrF9XCGp1+XSNQxJKw16bPTpjEoYY1UAEU5/gLjpGnxKKUoUMitJvvb+3hg63TWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302014; c=relaxed/simple;
	bh=nsqDXNkZwXTsf+6tguL2ZiseAsM7RgZBq8pEP0pSbOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6hpcs017J05Cknfbk8Sr0TLt6ghDlnuyyDBwMSyIdKihceLkrCSCqho3UttUBc9J5e8Rm8lNsGuCfpVNnYFyOXw5iR0o55qAGWWCRKJ58qj7kyPWPY71+mB2m6mOmR4Rwf49mgGrekVc4xlJd51M5rZt35zI06f2XBhWPy54Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOoth3Rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOoth3Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9CD1F00893;
	Mon,  1 Jun 2026 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302012;
	bh=T/utD/4+mpYQKXNjb/ErBYTWIOPpAPIvHwOZrSkS+b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AOoth3RperI3ISWvkgpuWHdm4KUN5IOuaHQ3CWhNjEswVEWgNjw9Bb1N9hLCEzW39
	 BjTbNKj4HCJCiNTleI1jIi8/qKlOvAqiEYThhUuyMDme//vPNg1rGEqWfHAuLv/yDH
	 mgyFfnFkfV+XDp2/dOZc01bNJ2UdbIk12A1sed1GxnsAbASLeQWfz7w4lUwsozSbI9
	 DfPYpgDd5dQCtUk4/7d2iW6Okd+mY9enQKrV49KXavcrBnqvCLW5reZ3tqQQCGeCvb
	 LKlnV8cdrW9yJVpZbSTHzr1HhDRo1GVpdiGa4qXVoC4b07tSKyUTv4rMgZ3xCps7O9
	 wVsVPDNyDZVvQ==
Date: Mon, 1 Jun 2026 10:20:07 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Radu Rendec <radu@rendec.net>, Thomas Gleixner <tglx@linutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Tsai <danielsftsai@google.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Brian Masney <bmasney@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jared Kangas <jkangas@redhat.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
Message-ID: <ah1At6tb_V2jxIfS@ryzen>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <ahC8Pyuatu_AvnZp@google.com>
 <ahDvvGew5UK3KSpi@google.com>
 <73f04f467e65b13fd455a3650dc2bd106af1e5a6.camel@rendec.net>
 <ahowweKTZXteLgZS@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahowweKTZXteLgZS@google.com>

On Fri, May 29, 2026 at 05:35:13PM -0700, Brian Norris wrote:
> 
> This seems to tell me the irq_set_affinity()/migration process isn't
> really what's killing things, but something else.

Hello Brian,

Perhaps a long-shot, but have you tried to apply:
https://lore.kernel.org/linux-pci/20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com/

to see if it helps your problem?


https://lore.kernel.org/linux-pci/r247uuc7ilkhn65vcbsaoxhgypif37lj3r3mvb7ooqqdg55vnm@vx3ip6klg6ha/
also seems to mention a recent PSCI fix:
https://lore.kernel.org/all/20251231162126.7728-1-manivannan.sadhasivam@oss.qualcomm.com/

Which also sounds somewhat related.


Kind regards,
Niklas
