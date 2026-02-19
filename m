Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B372FA0DF;
	Thu, 19 Feb 2026 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488282; cv=none; b=eE5UzhOmp0NC3GT6DWQF+cmFelVw2iqt1LlQNdbgDYnDdpzsTslxw83wGSbl0pOpD/ElPRwqlCf38vShqaCf0N5Vz/MVaRjBneTxsSk/JMg9R2ATI6oQH8IajbYJe0/o/RKdJjpnTIwOFeb0Z+3c6RN7ThVLBqy/lM7hWULU75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488282; c=relaxed/simple;
	bh=KENZGoGHKiImavRPgS9WMN9g1zcbTQmt4gksF5UhIxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf8J7bucli+8qSuZfLVib63QPqdersQz5+irBx2OqzxU6dEL8+6FH+SuwhWhW9ABvcEfkmasMpZP4NIX/Ad5D+z7B+sfGy312wW7KckqShr3tq1EE2QW2C0HMRuW2o00is45pq0QtJSu2Y9UM/p7t25B9R0owaypF117Pr6BIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C010A2020231;
	Thu, 19 Feb 2026 09:04:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AB74E4B2DA; Thu, 19 Feb 2026 09:04:30 +0100 (CET)
Date: Thu, 19 Feb 2026 09:04:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <aZbEDldZxV1KG_5B@wunner.de>
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com>
 <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
 <7b4dd756-2ab7-4331-b560-268f9cff0887@linux.intel.com>
 <CAJZ5v0gcZ5vs4WcS0GhvQrG9Kf05LNrNfd+oXz3WDdCA0xGjjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gcZ5vs4WcS0GhvQrG9Kf05LNrNfd+oXz3WDdCA0xGjjw@mail.gmail.com>

On Wed, Feb 18, 2026 at 06:33:15PM +0100, Rafael J. Wysocki wrote:
> First, keeping the ports in D0 may gate runtime PC10.  Does it not?

The Root Port in question is on the PCH.  I'm not sure, does keeping a
PCH Root Port in D0 also prevent PC10 entry or is that only the case
for Root Ports on the CPU die/tile?

If this does cause a power regression, the pme_is_broken() approach
suggested upthread might be a viable alternative.  It'll allow the
Root Port to go to D3hot but will keep interrupts enabled in the
Slot Control register.

Thanks,

Lukas
