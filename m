Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.95.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828475;
	b=GNiybRu/X4Kx3dQ4xTzkkq+nJ76Gp0Zfd1rwmTq/9UUvex2qKDIcaG8JaXr4tx+vW1JT
	 xwns7o8cw+p+DWk7i1mM+zJ+yNwhxjBcUyWEqxxvg+YdGsgVQnrO5uCeMgcHdLujyCeSl
	 /RaO5CeX6EYuPTLR4+FjwvFpvRpghy5E8Gx3LqWMPGJPaXMIR6mkE1JicKX5rT8LuGQnY
	 mO4Ec7anUae5mFDBCm6BUv2SSnDr64UxAkkaTIPI0Hq0tqMiJE5FqkD+ygMVMEfyZeQMP
	 91db/cwLCrR6fWInXSZb/HgwnhPWZMmYtOQhigbOi+cmPMfT+Oa1G/t0TN2MoSO/s9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828475;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NGdYE1LKN3He4j6aMDwu7jO4z9gNv0vtaxXDRhl5y3A=;
	b=3vUi/lR1YhJec63Q57FRrOPEuyzgAR2e1mDerH8wojVNQSwFOwLLYkpUD7OC5qRcs6kp
	 JObM6nY3oOoxpxWi3uKX2/bEgHpFz2zJ0QPQSLGCOL80jEPbKNvbra+1ZNWtQS0Vxi6No
	 4H5r0/SloLjZh/rsLQKb9oDO/B4ePZn9r/VYkj7wHshLBdtmJy719fJyzchGYHVGiw6B9
	 0Fz2ad6ZD+eQo+tvYT6QOduAVpVTSHKWDIM7uE+iCC829PD60h+YznZ7b0bpVaIV4ngaG
	 Dj/AfEnN06GGeMtdHvCoTrfR86HNlzpQRj0gkMBsOcFsHo6WfL3N4UaBSvPvX7WIg0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.95.204
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B65606A339;
	Mon, 16 Nov 2026 11:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14B65606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id F0C442973;
	Mon, 16 Nov 2026 12:27:52 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DAB806031F0E; Mon, 16 Nov 2026 12:27:52 +0100 (CET)
Date: Mon, 16 Nov 2026 12:27:52 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI/PME: Resume Catlow Lake Root Ports on PME with
 PME Status clear
Message-ID: <avrouGIdiXIxE_5Y@wunner.de>
References: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Tue, Nov 03, 2026 at 11:31:36AM -0800, Kuppuswamy Sathyanarayanan wrote:
> Intel Catlow Lake PCH Root Ports do not set PME Status in the Root
> Status register when they generate a PME for their own hotplug event.
> The PME interrupt itself is delivered.  PMEs from devices below the Root
> Port are reported correctly.

Reading the commit message, I'm wondering whether PME_Status in the
Root Port's Power Management Control/Status Register is set?

If it is, an alternative approach to quirking a set of Device IDs
would be to auto-detect affected Root Ports, basically by using
the logic OR of PCI_EXP_RTSTA_PME and PCI_PM_CTRL_PME_STATUS.

Sorry for not thinking about this earlier!

Otherwise I like this patch and I like how you managed to keep it
unintrusive.

Thanks,

Lukas
