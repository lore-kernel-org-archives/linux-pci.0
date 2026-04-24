Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC583E1218;
	Fri, 24 Apr 2026 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047303; cv=none; b=uPM/wlVNs9ueJ0aAXU6P6N67blDx9Qu3xo++IGf+b4cvTitSp1rjZeLhHianuR1wI243/3N81JRedWSI7rVUleFZ70th/wjlyoET22FrUPXRojpK2qOhmGARCNdcWkcIMVl+ZwttYBrHW3Ps3yzrmfvr2UHTopuF9hCzTKnbAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047303; c=relaxed/simple;
	bh=gWymGpGpXq+21g7jwi5PjVdg5u08V4zYbpTysnnQlPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qhbOEF4j3LJh9xunQZHzNI0A+1pNlK3bFE9z7cScuWV+F07uZvyvKtTVR+GrYpp3qummhF1c8M0T7KxIqY1BzMKyFWysUTPt3JQY2hLbEVjItRYGNz72uv6J/XG0mcjul0waUrojidyrGoTTSjcq5P0xvQwFJCE3UOKyiCD4IaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onvmCjrh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onvmCjrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3358EC19425;
	Fri, 24 Apr 2026 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777047303;
	bh=gWymGpGpXq+21g7jwi5PjVdg5u08V4zYbpTysnnQlPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=onvmCjrhRdvulbxsPIg7OL2L7izMUiw3X2ZZ9JyNrsUHXoCZzdcvM3CpJGwnJf1Zl
	 +SbXa1kq7hCNufi2eMOlpDl1c9h+Oq8z2jpffQ2Mq23smxc0lNrzWtQzqbVQx6jmee
	 qLFof/absvdyFiEZRL0t9jkhpxt/sHDbo0OpZNYyDKxowHJQXMrBqr0wHMubVMzP61
	 llb5HHSmeFbDD9Jf2Iv7/ckaeaRWyhxW8wN5+5T3pCBnkaITR07QfEGSY5LiXGKawE
	 cmndiKFvGuOwn+E1BnaMtlKcLFAxsu4tRbb4QXa0cyTeI/25XKqn6RQkihYyhVzzz0
	 S5FVlBOOG+5lg==
Date: Fri, 24 Apr 2026 11:15:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: brgl@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH] PCI/pwrctrl: Do not try to power on/off devices that
 don't need pwrctrl
Message-ID: <20260424161501.GA12467@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421104102.12322-1-manivannan.sadhasivam@oss.qualcomm.com>

On Tue, Apr 21, 2026 at 04:11:01PM +0530, Manivannan Sadhasivam wrote:
> pci_pwrctrl_is_required() is used to detect whether a device really
> needs the PCI pwrctrl support or not. It is currently used in
> pci_pwrctrl_create_device(), but not in pci_pwrctrl_power_{on/off}_device()
> APIs. This leads to pwrctrl core trying to power on/off the incompatible
> devices like USB hub downstream ports defined in DT.

Is there a user-visible symptom when the pwrctrl core tries to power
on/off a device when it shouldn't?
