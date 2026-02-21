Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F030CDAF;
	Sat, 21 Feb 2026 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700180; cv=none; b=WpNGp7GKoHxVrDq0QfgbQuqZXCOPVWB9MGzouf3PrEfwuQeX3/BncPcYSTajjoP13bqsFJXZkDUdskinCuwr06mdKUPmhD3qT6z8gYu+yN29YiApj/7x2CIevETt3hlRGHiITNE/YPJuf4B3Mo23kHsv+vANQEFURZ4UqZ9iZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700180; c=relaxed/simple;
	bh=UplSoHBDp0C7KLgjuZnxw/crtajsmQ6FkeGRVXaX+9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+8rvGgikGY0I1G/nnU9E8qPiMyXl8zkKnectdt8nxWX5y4Rhxtr+T69ucBJKi0FJpEzMZnRZZ7HB8NIUkb3nBuLPFUL4fklNtSCGif4xiRLSiBJr+Zi5VbXJL+OZ36QgJhqt25T6DpL9bxiSiOvqioGZ07HJcptPu490gcJXN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8B5C12020A57;
	Sat, 21 Feb 2026 19:46:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3B88F2D06C; Sat, 21 Feb 2026 19:46:09 +0100 (CET)
Date: Sat, 21 Feb 2026 19:46:09 +0100
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
	aneesh.kumar@kernel.org, yilun.xu@linux.intel.com, aik@amd.com,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [RFC v3 00/27] lib: Rust implementation of SPDM
Message-ID: <aZn9cfhv0YRxI1mw@wunner.de>
References: <20260219124313.GE723117@nvidia.com>
 <20260219124119.GD723117@nvidia.com>
 <aZcbBt7OmNeH3oA0@wunner.de>
 <20260219143129.GF723117@nvidia.com>
 <aZcnTnYJ61Kma0yd@wunner.de>
 <20260219173937.GH723117@nvidia.com>
 <aZgbukYiIxg44_e7@wunner.de>
 <20260220141057.GL723117@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220141057.GL723117@nvidia.com>

On Fri, Feb 20, 2026 at 10:10:57AM -0400, Jason Gunthorpe wrote:
> IOW the resume/RAS acceptance criteria is that the second nonce was
> signed with the same private key(s) that the first nonce was signed
> with.

What you seem to have in mind is essentially a "trust on first use"
model where trust is given to a specific device certificate
(i.e. leaf certificate), not to a root certificate.

Whereas the SPDM spec (and by extension CMA, i.e. PCIe r7.0 sec 6.31)
envisions a model where each of the 8 slots may contain a certificate
*chain* (comprising a root certificate, optional intermediate certificates
and a leaf certificate).  In this model, trust is given to root
certificates.  These could be vendors, but it's also possible that
e.g. a CSP operates its own CA and provisions one of the 8 slots with
a custom certificate chain anchored in its own CA.

Your "trust on first use" model could be made to fit into the
SPDM model by adding the leaf certificate (= device certificate)
to the .cma keyring and provisioning one of the certificate slots
with just the leaf certificate (and nothing else in the cert chain).
The verifier in user space could add the leaf certificate to the keyring
and provision a slot with it after having verified the device successfully.

That would make verification in user space compatible with RAS & resume,
at least the certificate validation part.

An alternative solution would be to have the verifier in user space
operate its own mini CA.  The root certificate of that mini CA would be
added to the .cma keyring.  Upon successful verification, the verifier
would create a short-lived certificate for the device which is signed
by its mini CA.  The verifier would provision one of the 8 cert slots
of the device with this custom short-lived certificate and thereby
allow the kernel to re-authenticate the device without reliance on
user space until the short-lived certificate expires.  User space
would have to monitor expiration of those certificates and re-new
them to ensure continued re-authentication.

I'm adding Mathieu and Thomas to cc as they have been exploring ways
to take advantage of the .cma keyring for Confidential Computing
use cases.

> Linux will have its own sw model, the spec is just the protocol
> definition. In the CC world everyone just knows the verifier needs to
> be external.. How else could it even work?

There are products out there which support CMA but not TDISP.
In other words, the CC world isn't everything.  The modest goal
of this series is to allow authentication of devices in compliance
with PCIe r7.0 sec 6.31 and the SPDM spec.  I understand there are
features and authentication modes which are important for the
Confidential Computing world, but CoCo needs to fit into the
spec-defined mechanisms.

Thanks,

Lukas
