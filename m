Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2A2478847
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844524; cv=none; b=VofWPJytErRkJZgVQDxk9gq6bVuvjdi5pCQM0b/VEn4cImxZCYaadl8rAUoM13mTiwSmZriYDgYUVb0o7C9pZ83QT9WIZQedxjNiZt+p7OZI2tSJ38N/zisIgOF/bdQOSkhUReUvRqxNsnwqSdmlbM16JLN/1G0q5p1DuuXrv80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844524; c=relaxed/simple;
	bh=B2pCGB2R84oUjxfKmR5X5jjIPVkx8RdTbykZZitM9XU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NTumAbCl92tb3mCywYlyVH834OoN2EmLiAN+iihgfNVATMByO1bhqUqcY3/c+l+ibXtHGPCX6YjoNAjkKi2OvZcIwkmnNEf7bvaGSrY3fv+CzJk4ASxuDaMIQM9WYf39aOyWTE/Qj0aEKS3Q8sFFhWp/GAor9Dgzu6WHTIA0QgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmu9uT5D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmu9uT5D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAADC2BCB0;
	Fri, 15 May 2026 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844524;
	bh=B2pCGB2R84oUjxfKmR5X5jjIPVkx8RdTbykZZitM9XU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pmu9uT5D4N6tXplPK1u2teNUvA7i+8L5VxvaWfXoFAIVbefKefWPOyIhBc+8kkmHO
	 Fa3lZKDz/nH9f1GhbGMFtdRpt6VKmlkntv7NJcPcPS+yL4z7vVm/AyQ1Ny6Qt8Ti+4
	 wqm9nfglij/PYfHrnrGX0dx0uSx5Jb7Z4uHbDjGeH+a6eJhF0/HriVYJvBFr2831eW
	 osC2HvjvrdiyImMspyjAYPTyyEfZx9bKhQFNB6UwQauYjhNei4r5zG2D9VD9QWUiuL
	 fGdrOeS2iWZXH9/JiGPNRr5HsY+z8Nh6MofnVuu8UGcXu161f0ovcPYRMN1pHH0Lg3
	 UcEM1pf3WmywQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] PCI: ibmphp: Simplify ibmphp_init_devno() to
 take struct slot *
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pramod Maurya" <pramod.nexgen@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515110944.216993-2-pramod.nexgen@gmail.com>
References: <20260515110944.216993-2-pramod.nexgen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 11:28:43 +0000
Message-Id: <20260515112844.7BAADC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unbalanced Lifecycle Operations / NULL Pointer Dereference on modu=
le initialization failure.
- [Low] The patch resolves a documented TODO item by simplifying the signat=
ure of ibmphp_init_devno(), but fails to remove the corresponding entry fro=
m the drivers/pci/hotplug/TODO file.
--

Note: The standard inline review format has been altered to a free-form
summary due to recitation restrictions. No direct quotes from the patch are
included.

commit 10dfdd5d4dd69d8f479f459382630a4bba2b9d73
Author: Pramod Maurya <pramod.nexgen@gmail.com>

PCI: ibmphp: Simplify ibmphp_init_devno() to take struct slot *

This commit simplifies the ibmphp_init_devno() function by changing its
parameter from a double pointer to a single pointer. It updates all
internal accesses and the call site in ebda_rsrc_controller() to pass the
pointer directly.

This isn't a bug, but since this patch successfully simplifies the function
signature, should the corresponding task also be removed from the
drivers/pci/hotplug/TODO file? Leaving the resolved item in the list might
cause some confusion for future cleanups.

Additionally, while reviewing the call site in ebda_rsrc_controller(), I
noticed an existing issue in the error handling path. If
ibmphp_init_devno() succeeds for one slot but fails for a subsequent slot,
the code takes the goto error path. The successfully processed slot remains
in the global ibmphp_slot_head list, but the pci_hp_register() loop is
bypassed.

Does this cause a panic during module initialization failure? When the
error cascades up to ibmphp_init(), it appears to invoke ibmphp_unload()
and free_slots(). Since pci_hp_register() was never called for the first
slot, its hotplug_slot.pci_slot remains null and its slot_list remains
uninitialized. Calling pci_hp_del() and pci_hp_destroy() on this slot
looks like it would dereference these invalid pointers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515110944.2169=
93-2-pramod.nexgen@gmail.com?part=3D1
