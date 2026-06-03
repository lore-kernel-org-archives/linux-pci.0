Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC040C5B0;
	Wed,  3 Jun 2026 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526187; cv=none; b=Do5GfZSEYvfsj5GNgiXIweG07RtqNhwMFknbx9lx1hPwuGWQyy6Jpwpkgj2SdqkVgtyztzcIKuD3Mqqk4feQLnesP6XOI5+vH6wQ9yJ1zduKfm6p7GE0u+LeW2jCzuAFr+vZhNNiMzGkXNWUGMr5yqGzTanDNqCXpcByfBHaDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526187; c=relaxed/simple;
	bh=RfPJKSeybPeWRgtp5RMajBOrCCB47tMntEjDDxuhDAU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jFcJClJ6vH77GBSKTN1eKy44H/GGBnmPKXi0d2qzjum4tVTdOUHNIkcmWywoSW7NZGan7Vse/kQTq86SP2Q7gpiMYgpvfaI98ECSvxrqkAELl9DZV6X+pLz0oMdJAzSoQjgAZPasbVpMaaJv6Ba2oh5wd/l9wJ7x4v43VrGZm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5kvhnnP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5kvhnnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9182B1F00898;
	Wed,  3 Jun 2026 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780526184;
	bh=JIxYjoWiowSKwi44sTyCfsuEnLjCg0IF1uIMr3/kQBc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=k5kvhnnPyoDMnuje+j9BnJirnZ7E/H0wbO2gHXrI6P1bH7w00LkOUPxCoZkN4aMTn
	 IebrA/i8cZO7V4vbFHbjAMcpd9ei4hdDdCspF9uq5zRTrqlajS2+nZgF5Q3o96d4a6
	 BQ6OURXVJoKyZ7HCtHPmwfSKYmqYwNPTohBi6RTHxd/MK60K89mHeHLCrLfmdgF8lH
	 O107uWweluJi4A9zM959r4x03QA313xVlHLDGlcRTqkan3cJU8G0vKXqr6CxLa4TOt
	 poE4oOtE6jnTwXyFp3st4axD7Rr+DIaPCRC0IxUd5qcG58gGgfGxzfuGzhNKMlEad+
	 88A3gxzIYINcQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id D8CC6F40077;
	Wed,  3 Jun 2026 18:36:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 18:36:22 -0400
X-ME-Sender: <xms:ZqwgarMCavRs4y78ctVzvcza4pVYLID-W2DRIxQ9lnc_m1ZRw0KjzQ>
    <xme:ZqwgaiV4dEfiPXBXpPZM47hiP_ieQ_Yjse1PjmNYepKrk4BdLIaTNBt0z9tKVUOe1
    2d29kj9ablWfbq5osy5OW2z3-w1LA0Scqa7pxIedq6i7R8QpxzCEB4>
X-ME-Received: <xmr:Zqwgauv2Xyvcf7Gb9lBk3gnxo8-D4LOMyu3HrzRJ7qmUpa6RJ-pqIDP1zPVZiYFCgP1IGVnk71ZrZJ2VoJS3GD4EKjF2Ni8gYIs>
X-ME-Proxy-Cause: dmFkZTFX0j9sA6Wn6+0SHbB+uAnsGUuUTkIQ/IG92bQ8SWXL+2nOfGVQYN3SuFpcuyraSy
    gwilbXDO2FeldZhYaMLbp/icLYg2aI/62Vz1d6pgPJHELN04Hz3biMknEMug0aTN0YKs17
    6OVgLgH1oXPT49MIJL83dUy7zwS2LqADZczGc+s6oFiY893y36qw3Nw4WxVeNfy5fdNHxE
    1NReFr7YSnTLG1+7Fka8iFyXEVQuzfuk5/D5SSn3UamAFriCIPaBrMa6tx0rksq4zxZREQ
    7O5cjH8ayu5kLs+O7WmRQdQWmYYzMFq9AnD1HvJQbGOL5L71Yt2K9Kq3WcRFI7b6U73mav
    XWs+YhLBl1JCwkCjEzEW7Vdv/3hf1tZyiirszropr/pgNFN7qQX9g6OiGKSR5c96xN5ne7
    SPLMdVdqx5Z0WG3eAnoW57uNNDti+nnERgF8vIXLbR3gKxNhPfrxxQkEs9kITU9vb7jwjW
    A9CzD33wBXRWv1gXJ4166Xgbosv5P2jimXb64QUsz8g8g/R4w2+yflB8rW9JoVdEg4M8vt
    i9GWPk+8Yh/iRTPXMyuOeO/+GweHdk79ELJIw2yaBy/HPFsI6ul5qBFyJo5dmm7QNqljkM
    0AOM3kV2GoSbmrn1fBZZFpyS5w7ZtAzZKlehE177dx5mm9vUp+G++tlQBIGA
X-ME-Proxy: <xmx:Zqwgat1YjKFPNKJJhtRpEx7bMyzUUaWpC1MO1UVFCMwV9jF8axxsTw>
    <xmx:Zqwgav4DGx8SkDMbnuH4josgBnWt5whHl86A7d0yzlueR77ZeDVbYw>
    <xmx:ZqwgakULppFqhRdIi2bd1vQcB_k3E5G_BGDaP2WkZ7LTZdhTBQoNOg>
    <xmx:ZqwganjPmf_OTM5J0gxNR7r_XbGi_w0yu3mro98rn2ESaaAzCp7WWQ>
    <xmx:ZqwgakeZLYt2xR1iZX0EwN4A8_6U30cCN8Dq8-XZgkv85csAawuNutsc>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 18:36:22 -0400 (EDT)
Date: Wed, 03 Jun 2026 15:36:21 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a20ac652ec2_42b91009d@djbw-dev.notmuch>
In-Reply-To: <20260528083154.137979-3-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-3-smadhavan@nvidia.com>
Subject: Re: [PATCH v6 2/9] PCI: Export pci_dev_save_and_disable() and
 pci_dev_restore()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srirangan Madhavan wrote:
> Export pci_dev_save_and_disable() and pci_dev_restore() so CXL reset
> orchestration can reuse the PCI core reset lifecycle for non-standard
> reset flows.
> 
> These helpers invoke driver reset_prepare/reset_done callbacks, save and
> restore PCI config state, and disable the device while the caller holds
> the device lock.

No longer required with the plan for built-in CXL helpers.
