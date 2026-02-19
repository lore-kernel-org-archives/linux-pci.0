Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A3274FDF;
	Thu, 19 Feb 2026 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493699; cv=none; b=bT03nTDoaPs+l0TZmY6iEVpI3W0E1GILH21MwPyFb3cjnhU4kjEWUn7ZUtSm68NS/7MhohTL0nWsdhEdBKKNcFyCj6a8ZhPvZacw9XCcZPu390gbvBVG2bWS//uWDduzlrzI0P30R3egTtKmhC39bOX8MPqU2vdUxm1W3hVRa9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493699; c=relaxed/simple;
	bh=Iua6KMSkg7G9ZI+0WVSUG2RjUEAj7AQOC0BZSnYC4GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZP6C3EzGfEXfK2nisvcOyWjOMz1E9illE3zpT8wM8r2FiWTEwSMGZ3cBiRRn/Ja43us1h/W0qT5t0o1a417pq40s2c/dEY9llQy/mCQolD5KOfKKTSoVautzRMIdQNRjiVE5gmGutwuy9RX+WZVvgg6EZ76QhfgWJ0/XnRb+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C4BE4202010E;
	Thu, 19 Feb 2026 10:34:55 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id ACEE83D036; Thu, 19 Feb 2026 10:34:55 +0100 (CET)
Date: Thu, 19 Feb 2026 10:34:55 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: dan.j.williams@intel.com, Alistair Francis <alistair23@gmail.com>,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com,
	benno.lossin@proton.me, boqun.feng@gmail.com, a.hindborg@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, tmgross@umich.edu,
	ojeda@kernel.org, wilfred.mallawa@wdc.com, aliceryhl@google.com,
	Alistair Francis <alistair.francis@wdc.com>,
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <aZbZP2-CadoUR2Wo@wunner.de>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260217235604.GA1595019@nvidia.com>
 <CAKmqyKNeyEN-h9tAnfM9j0GWiFU9idXheGQ1COCqT9MVZgsZYw@mail.gmail.com>
 <69964ddaa5471_1cc5100c3@dwillia2-mobl4.notmuch>
 <20260219005614.GC723117@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219005614.GC723117@nvidia.com>

On Wed, Feb 18, 2026 at 08:56:14PM -0400, Jason Gunthorpe wrote:
> And not sure we should be dumping any certs in sysfs if the plan for
> the other stuff is netlink, it should be consistent I think.

It has turned out to be super convenient to expose the 8 slots with
certificate chains in sysfs for direct examination with openssl and
similar tools, without having to go through netlink.

Originally the plan was to make the certificates/slot[0..7] files
also writable and the kernel would implicitly perform a SET_CERTIFICATE
SPDM exchange with the device when writing to those files.
Unfortunately with SPDM 1.3 the spec editors made things more
complicated, *cough* sorry *more flexible* with additional CertModel
and KeyPairID attributes.  That additional complexity makes it less
suitable for sysfs, hence for *provisioning* netlink is indeed the
better choice.  But just for *reading* the certificates in the slots,
sysfs exposure is very useful.

Thanks,

Lukas
