Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792915652;
	b=c7Lp+oW5zwPxOiCMlLuOLWztRvUCoZvvQ4kiMk12Xfhx6/mZQQcqV15mNhfs7ebUiEGR
	 z2obG4DXQZlc/lr7Nx3tKYorgfz6CMhikVeWXaKSJ7t6w7ogUdpg4oxfOHJqdNGbJaLhU
	 73aPh47DDO4YFAZNJxIgdFYQDGy+zuZPm8Qd68/jbEGUHvG+yXyV/kaEd0xp3FQdoC/X8
	 Wa2Iiauz7QLzu7UsHobScaxFQkpQ8/2i5BGbTEwTzDNu20jgeD79w3axZEv2X1Oy0964v
	 TE4QnhDUFAEzY9ota8XX9HZxc9YNwMPI9qmxTtQc0PGnixIsBMZbuy0c2pULGAh5rng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792915652;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:User-Agent:MIME-Version:Content-Type;
	bh=4GigSNlun9xYHyffKF7UfUd6N/I0WCZ5eZ21BQnB1uk=;
	b=sQyWxazfkouQDtp5GgVdYFuFpxJk1RxsFEMKu6o6D3fLoJ5PQpOQLb7CYqIfXmeSz+KX
	 NEz1NJXoWJO7jhGcZ6xRdrNv5sdH3sMlqiWor3JSR/pnEnQmdmAm+os+VmG7hsP/GIZv4
	 21sRptrNq+QjHuLrF9xi3ckKfQc03jiwNz0OXW+kgdFq2enBdEMD+tfCq+jPYh9KbhYlF
	 F8csQBfnaMfv30rQ5sDkuhHrkXhloVaqGazk6MOKwx/wN6WxaDI7NGicJwHf/DaEUuSPX
	 pP0OyjQITup50kr8UvGjhpanOVn7wcmdb6vA+VaH+3XB3qGKMsYbHD+Irl4O6ALiqKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB0606A31A;
	Sun, 25 Oct 2026 08:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACB0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id E3A1C92009C; Sun, 25 Oct 2026 09:07:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DFFA792009B;
	Sun, 25 Oct 2026 08:07:28 +0000 (GMT)
Date: Sun, 25 Oct 2026 08:07:28 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thorsten Blum <blum@kernel.org>
cc: Dave Hansen <dave.hansen@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
In-Reply-To: <as0mu05UzFWBBRJ7@kernel.org>
Message-ID: <alpine.DEB.2.21.2610250743510.42255@angie.orcam.me.uk>
References: <20260916100206.92853-2-blum@kernel.org> <asDr0tWYBNC296EQ@kernel.org> <f9b1c1b6-03d9-44fb-bdc4-78342b05f2af@intel.com> <asLw3ZfDy-rDxwtv@kernel.org> <as0mu05UzFWBBRJ7@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
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

On Mon, 12 Oct 2026, Thorsten Blum wrote:

> Is there anything else I can do to help get this queued?

 FWIW, it's not unusual even if not common for multifunction devices to 
have "holes" in functions, e.g.:

07:00.0 Parallel controller [0701]: Oxford Semiconductor Ltd OXPCIe952 Parallel Port [1415:c118]
07:00.3 Serial controller [0700]: Oxford Semiconductor Ltd OXPCIe952 Native 950 UART [1415:c11b]

which is a chip the functions of which (one or two native or legacy serial 
ports, one parallel port, one GPIO interface) can be activated selectively 
with reset straps, however the resulting numeric 0-3 function assignments 
for individual interfaces are not necessarily contiguous, presumably to 
simplify internal decoding logic.

  Maciej
