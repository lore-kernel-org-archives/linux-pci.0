Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ACE41B8D5;
	Fri,  7 Aug 2026 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090649; cv=none; b=pXlm4eDZy6ugtmdRKgRlupeh1FZ4h6XVCdSUvysfQxRXy2TX/HPgNavtay6IzNMfL9UCVR9feEKWopgHp0hTV01d3OzRB42CN6jvW2NmntluY0FMC0J9NsDPdPppVX93kGb815lsYJ9P+ggOWc6qEbVlQSlqNx0lJjvndFbTa+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090649; c=relaxed/simple;
	bh=Lmp9nhyGbsc18daKj04uPFwcMV7wBRWnVZH0fpng2wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKngslm5RBbYIdc3qni/mSnlg93odenV/wtKoVDYJ4JatpLRIGpSth8s8uCLKkAQJKdmbYmbeQ/lKGmO54pYzh1YXYrG9jtkz2/dp1tw3V6dMIs7Dl+uggMsdK7w2d68zW/qDhVfu/DFyKnc6m8nzUC8R4s9hPg2hOTMyttnlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 900E2F43;
	Fri, 07 Aug 2026 10:07:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1E934603403F; Fri,  7 Aug 2026 10:07:48 +0200 (CEST)
Date: Fri, 7 Aug 2026 10:07:48 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Max Lee <max.lee@canonical.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	acelan.kao@canonical.com, helgaas@kernel.org, kaihengf@nvidia.com,
	victorshihgli@gmail.com, pandoh@google.com
Subject: Re: [PATCH v3] PCI: Disable ASPM L0s for Realtek RTS525A
Message-ID: <anWSVNqltYAjvq2p@wunner.de>
References: <20260610024723.188514-1-max.lee@canonical.com>
 <20260706025358.516607-1-max.lee@canonical.com>
 <jnxtx4pl36dzuddqugpfack5hfmwo2wazg5t7g2sill37urtng@3bvsmzehfygl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jnxtx4pl36dzuddqugpfack5hfmwo2wazg5t7g2sill37urtng@3bvsmzehfygl>

Hi Mani,

On Mon, Jul 06, 2026 at 12:20:07PM +0200, Manivannan Sadhasivam wrote:
> On Mon, Jul 06, 2026 at 10:53:58AM +0800, Max Lee wrote:
> > Prevent the broken L0s configuration by removing L0s from the RTS525A
> > advertised ASPM capability.  This avoids enabling the non-working ASPM
> > state instead of masking the resulting AER Replay Timer Timeout reports.
> > 
> 
> If you can add the AER log snippet here, it will help others to find
> this quirk in the future.
[...]
> s/Replay Timer Timeouts/Replay Timer Timeout Storm
> 
> to stress the severity.

Max submitted a v4 which I believe addresses your comments,
but it hasn't been applied yet.  Would you be able to apply it?

https://lore.kernel.org/r/20260707021527.639611-1-max.lee@canonical.com/

I'm asking because there's now another ASPM problem report pending
for the RTS525A:

https://lore.kernel.org/r/20260806214808.1202819-1-derekjohn.clark@gmail.com/

Thanks,

Lukas
