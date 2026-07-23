Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AE376A13;
	Thu, 23 Jul 2026 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840015; cv=none; b=uvRkb8vMIM2xB23Upjvz1XZoaFrCD4PcBBiCfZw6mVCkZnzimHmVA1Zu+6ZxTZafHt7rl22jvrDIZ8QGEZNeh/Jn7nFwdzonQ92ZyuTDlFW2xKSxTXa6VZ6wHVWQ9Yr4ulm/+uT5BdB4Sa82guZSloAfYlitUCeZwbD5YR2Bj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840015; c=relaxed/simple;
	bh=+yyrVCSALxKd+wydMZFhMIEn2LEZ8lnBDlMZVBmr2C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1raQYN1osN2LS3YxA+ZRMCCVslHrikRGZHy1LnLHLLRbiu6A8TdaH7pm8rnU8CnyIwX0/RdL1AX7yLWttzFy4ERzu4G1LKGujdG1vBI+T6lwBN3eNf6JosBuNCFFwflQDh/bN6mDqdJtdTo7CUuDk2F++nhoS/P7mpSovrFHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK7ab2yN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK7ab2yN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27001F000E9;
	Thu, 23 Jul 2026 20:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784840013;
	bh=+yyrVCSALxKd+wydMZFhMIEn2LEZ8lnBDlMZVBmr2C0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bK7ab2yNAZwkH9b+8Ue228FS3c71Us30g2PIRc319nff/GA8jlDJAlK14hkPJlzE+
	 8nl75v3PH/iamIxUWx6XKBHrrnYTDf7iWoaV7plFqWeJwnRs0dMuz5ZWbWCE9NW5ya
	 X3W8vXt1ntFYN+YsTMPI6wpZllXonvMu/N7mlqsku2LbP2Zzux0xHGRFxWGjXYD7Dg
	 b9X2uXYXz0wG/n46BVE9VqXjecw/sntO89ZU7yL54yDenTPNXb+Blj0AQ7Mpc+3whr
	 QdK5Q2NPVoxHLqUFsRIr5ZsETId39GmMCBWQxo9VdcrbNyZ0CJ44xTdr/qpFHpSsBa
	 6b3kYiXVszbjA==
Message-ID: <33490805-bf55-4321-bbb4-1fec8a0d7646@kernel.org>
Date: Thu, 23 Jul 2026 22:53:25 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] rust: pci: add sriov_get_totalvfs() helper
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Zhi Wang <zhiw@nvidia.com>, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 jhubbard@nvidia.com, ecourtney@nvidia.com, joelagnelf@nvidia.com,
 apopple@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com,
 alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, nova-gpu@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhiwang@kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 David Laight <david.laight.linux@gmail.com>, linux-pci@vger.kernel.org
References: <20260722073913.1807677-1-zhiw@nvidia.com>
 <20260722073913.1807677-3-zhiw@nvidia.com>
 <DK5PCSJORNAQ.SAAUYDBMSESK@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DK5PCSJORNAQ.SAAUYDBMSESK@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 7:30 AM, Alexandre Courbot wrote:
> The series looks ready to me, but we need a Ack on this patch to take it
> through drm-rust-next - Danilo, does this look ok to you?

Yes, I picked the whole series with two minor changes.

Thanks,
Danilo
