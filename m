Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026830;
	b=hh7gCHBdY6oAGgBbqAXs2/KlBNCBRLJzdn3Uk0Ovb0Nq7Z0kNawLRPlw89HoXOuXxNwG
	 +c6F3U+tE0rILWI0vmGtP9Jg07nAiTn08vqxlEKqcHQ2fJodnyKtOhPQUXDoBNgiAFqin
	 zm/Xg7sP8sHWqu7AXJAE7QhdiaIJHCQkLJBWxCTCzKV/kRTOftuxQ9btIKEJIK6omhRv/
	 qLpX0TLEoRa6Q5t7gBEkpTPE9bH5Vh/8xYq3odozMq4qZV4RiVH0YxzjsXoCPrVfifEHT
	 Wn3pJjIVRnZWm5lFgPL/9RKrMND6ivqbxosO6GxGmbnE9stUL2/kqJGlx9dUa4AT8Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026830;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7D1qR2T1FcniBmWlpu66093qFwaBF+qRYqkH/VEScx4=;
	b=OG4v5wShIVcOBwp+GyriX0hheOzShmYBYJUg0GfZzt1gj/T8ZtMzJsPhZd/S79zYFMFW
	 zqsOK0+BYR90M+XWMM6AcV5GydtA/8JH9rrN4Y0/1yBmXPc88rfX62UQVjRP6xKTPFy5X
	 2S7ZVmYr/HqDgIG2YE+6dMifDyOIwb2TExy4A2YHZLgf0oNYhM+yKtS4XCuE+BTXF3peR
	 v/SOtpW9qsQLb4KUnGPGOE7+M7tHrUPe+OJgENzLSrv4I/QvDP1JiHKuScB/KI1KLkmwV
	 xSKZBFnVblyxHN3RzggX08Y5dI8uFmRvvaTQH/gyYoMbei97z4VIl4slBL+ZUkVZNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUbEJQYc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279C606A31B;
	Mon, 26 Oct 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUbEJQYc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBB01F01825;
	Mon, 26 Oct 2026 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793026830;
	bh=7D1qR2T1FcniBmWlpu66093qFwaBF+qRYqkH/VEScx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mUbEJQYc6xdq2uoq7a0/pCJhYgVmY3Lz5mPpyVD4T2cCviHXoWh8rddtJv1FZ+B16
	 nglZZVyokTra52VgTpHchoNder23YudWMrGzHJi0y4obaivMBf+ajSGcmA+MIYhyuz
	 +PkK/16DPdZrBDJumpzO6J5PkiV+2IP2UeZOeSfTpBN+2LWU8puUS9DZBYX4z/kjul
	 vzls+PN7KI/XzU9RphZnDM3mTjwwTQlOnOLFPP4DsXJir8rLquKImmar+dnbIMLCQC
	 +beOrKmn7hRVM7PfZ+cisTH2wW63/YRiC13c3BkHeGpaukQq5eLjiZ6Cue8w+p0gAk
	 Oh2fIWFbh5VyA==
Date: Mon, 26 Oct 2026 09:00:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nikita Vetoshkin <nekto0n@meta.com>
Subject: Re: [PATCH 2/5] PCI/sysfs: Use user config accessors for bus number
 attributes
Message-ID: <at9rDMzMCXpaQgPB@kbusch-mbp>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
 <20261025000836.58294-3-thepacketgeek@gmail.com>
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
In-Reply-To: <20261025000836.58294-3-thepacketgeek@gmail.com>

On Sat, Oct 24, 2026 at 05:08:30PM -0700, Matthew Wood wrote:
> secondary_bus_number and subordinate_bus_number read config space with
> pci_read_config_byte(). The kernel config accessors don't check
> block_cfg_access, so a read that races with a reset goes to the device
> mid-reset and can fail or return a bogus bus number.
> 
> Use pci_user_read_config_byte() instead, as the "config" attribute does,
> so the read waits for any pci_cfg_access_lock() holder (e.g.
> pci_reset_function()) to finish.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
