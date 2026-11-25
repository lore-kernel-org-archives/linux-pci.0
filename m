Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607188;
	b=nZ1BmKba+sqt5qvGns1J/vv85bNQQmoNunNW8fyM4P34v6oEZFxPbl6pNy0p+K6Ddc5A
	 +FoMdFn2L27Jd+apVhp3Mu4bi+v10WQfcbcKcxvh4hCIEmbco2iW5vnca06B6SNOZn5Xn
	 F934qL2EJa4FFdIqpRlHPXol+yXr5VITYXv92t1hoTCguLS7auoP/mISI+IYWIWooSWT0
	 aYWg7qAZ8UV7UMIq9Yz8yo5ovI8OcGk322bMWnn6OZ58ykWJslh1Lx4tS9WA6Z3ZhTN+U
	 ag95DAir5WIxqGvgzJz+CsfaY2hox1OjVEm0x54dFKcJ9jiu78ERESlGcvmAhpZ7/jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607188;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=T7zkolkFMKYOxaIu4uY3+f5ExbYbUFTTgg9c8/7Kz+U=;
	b=VA0qYaz2eDC/bQ/ZPqgYHHoKRAs6i5P8clbiUHTNQjW1LeDvxeGVbai3NsUGkIbO23k1
	 DhDeaNT+1zlPNiTFbDdmGos5Ic9pGS3IG+WyUa3XBUELBhwpcFVmdJHuF23IN/J201Qi1
	 F1oNF4iiQN34yYDvCMt3jMUs7ls5BU0TLotMU8UWJ9PWb8KbIjvFFf25EScy9fuN7YkQP
	 llzD2hxZGwCAejEYldL76D4SjvCiTVtnN1mJ/kpAiUHVsltvMKdR3uWF7KpvxmFqyl+Oh
	 gYTIAH05pYywDN0qC/GAOldryVEk07mT+m+2Xp4p+Otsdwf5jjkVhZ/Qc6CNLfF/zeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=wunner.de;
	spf=pass smtp.mailfrom=wunner.de;
	arc=none smtp.remote-ip=83.223.78.233
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6880606A321
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 11:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6880606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 212811063F;
	Wed, 25 Nov 2026 12:46:26 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0E37760272CF; Wed, 25 Nov 2026 12:46:26 +0100 (CET)
Date: Wed, 25 Nov 2026 12:46:26 +0100
From: Lukas Wunner <lukas@wunner.de>
To: ChunAn Wu <an.wu@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Keep ANFE masked on PLDA PCIe-to-PCI bridge
Message-ID: <awbKkqYgV3O3ay4g@wunner.de>
References: <20261125020013.639193-1-an.wu@canonical.com>
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
In-Reply-To: <20261125020013.639193-1-an.wu@canonical.com>

On Wed, Nov 25, 2026 at 10:00:13AM +0800, ChunAn Wu wrote:
> Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
> Errors"), pci_aer_init() unmasks Advisory Non-Fatal Errors (ANFE) on
> devices with native AER.
> 
> On a Dell server, a BMC VGA sits behind a PLDA PCIe-to-PCI
> bridge.  When enumeration reads an absent device on the bridge's secondary
> bus, the bridge returns a UR completion and, with ANFE unmasked, also
> signals the error.  Platform firmware reports it as a fatal error even
> though the hardware severity is non-fatal.

So is bit 20 in the Uncorrectable Error Severity register of the PLDA
bridge clear, i.e. set to 0?

Are you using a kernel which contains commit 79c168e2aa95 ("PCI/AER: Skip
error recovery on false alarms")?

Is this reported through Firmware First error reporting?  Could you provide
dmesg output?

> Set no_aer_anfe for this bridge with an early fixup, as done for the Apple
> T2 Secure Enclave in commit 7209846a169f ("PCI/AER: Keep ANFE masked on
> Apple T2 Secure Enclave"), so that pci_aer_init() leaves ANFE masked.

The issue appears to be confined to this particular Dell server, which
suggests that a DMI quirk may be appropriate, instead of disabling ANFE
wholesale.  The same PLDA bridge probably works fine on other systems.

On the other hand, if the bridge generates the UR errors for every access
to an inaccessible device on its secondary side, this might become quite
noisy and then indeed silencing the errors might be the right call.

I lack enough information to make an informed decision, hence my questions
above.

Thanks,

Lukas
