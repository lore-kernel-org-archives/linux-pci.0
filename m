Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6A2AF00
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 00:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195638; cv=none; b=sjtn8t3qEADSUpJId4EH+ylp/e2TLFnXgKuqSFDuDje13P07bS5eswTkFt5gmB6HQ5tyekPzGEQ3AYGy7OJa7IbLy22jA9ipGgxNJ7tTUTPqKrh9SYgIz5B9KzRnf2myoQyy7Yvr/XBhx5ENMBf4tObBN+w3kk7iLkNWSKPS4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195638; c=relaxed/simple;
	bh=yHgiR4a81smWGbufMKV+59ZXEXxnIOx0PczChkcd4ck=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gbPF8QLRzx5iNhJ03pt4BOMOEKAvhN46yvO7qYko4LCpHk0Qx4Vr8Dsj/xdOHvzv8fHVQpksKzvJRJfsD1psCFeWljiYox7l0PpDXHh3Q4L55tehfwFZhhpzbdBHGbs4D6VdbiHCXrjjBWHhvRq0U4gz7qABaaG3iGs2gYRrGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCNTnc4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCNTnc4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0101F000C4;
	Sat, 17 Oct 2026 00:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195637;
	bh=yHgiR4a81smWGbufMKV+59ZXEXxnIOx0PczChkcd4ck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mCNTnc4aNbKZdRREqzbsuCtYpYFbrPCHRnPI65znUJ/w0mqsm8n60P+ahOhdrdUPX
	 YvtLKOiN/g+VKRUp/qwB4k5z7r+iajcVnm98lwJgcfcFkmlYhrsrR3t+XwxUy3OtDD
	 aKV06heZzdGC0SimZvLRUBk12uDHh5e5hfkaeQ5Wp/91gX1oJ0FOR1mQBSz7vAOjN8
	 5O+vhbVN71eGF1W44AF0Wp75p5Rbk8kQXdQC18E7US33ejUhFPZVcAEwthCrGdsc9Q
	 CqE4JP7LdKGVshI0k27yb2502uC30D2yLKVoAo0HcrISybl2qY2z3lLaA2BQtjdiOk
	 3PEIc62aDuw7Q==
Message-ID: <sashiko-outbox-175058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: use reset_root_port() for bus reset of devices
 on a root bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
References: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 00:07:16 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The "bus" reset method resets a device by asserting Secondary Bus Reset
> on its upstream bridge, so it is not available for a device on a root
> bus, which has no upstream bridge.
>=20
> Some platforms have no Root Ports and expose PCI devices directly on a
> root bus, e.g., Hyper-V vPCI places each assigned PCI function directly
> on the root bus of a virtual host bridge. Such a device has no reset
> method at all if it supports neither FLR nor PM reset, even if the
> platform is able to reset it.
>=20
> pci_host_bridge::reset_root_port() already allows a host bridge to reset
> a device on a root bus in a platform-specific way, so far only in place
> of a Secondary Bus Reset by a Root Port. Use it for the "bus" reset
> method of a device that is the only device on a root bus, and wait for
> the device to become ready afterwards, as is done for other reset
> methods.
>=20
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016235940.9420=
90-1-hamzamahfooz@linux.microsoft.com?part=3D1

