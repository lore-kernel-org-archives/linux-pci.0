Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820902;
	b=y4YJb5xu7z4y2NTly76tK0YuufsV1asznFD6yaV4300vCeTjuB5Z8OiY89tATk0X+dPn
	 IT5PNzCzN0Wv3VPnD277cGe3/weftiGZm+yO6ET+ZK4j0DkSr+uYPop4GDLSDbqivpQSJ
	 0aNUWmQ59bB5ftH8tQX5hHu7dmQLUAmibb8UpzOtwDO4gGN9GJkFmPO9bHuSBsiGwrWRe
	 PO4/3EdYtrpkCR0zLja1tmBwGEUeTVU8XNQ+B7yUGEVpUsa3yI/rvGARYGNkStwZ/zOoO
	 z1gszAB2XHTzejxwSsYh4TRdP7o59bn15MaDFRdeEo7tBtPZpRE9D+xly0p6+6dqK9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6qMiNAXonRcpqrHA/noomKNgnzoBcCy6IIUuJqY3UOc=;
	b=08dp/7Veh7BJyKVYpFvW9waXdo4GQopc+RePTHNUmoZfoR2hNebUp5fEf+RsJkL94+vu
	 06cM7gsMCVUb2CxvEzAjjrBE5pCWQ9ivzCq+w8cOrCcXCaldrVy2FIyjlZ//tt6jiBDJQ
	 e97qS1q/lyWM7Y5k3O+hxSZFc1jXLLzaI1ivih3zBf3HJvmm0z80jmEMPCK781p/tUKXa
	 tBPrA/28c122SLZkw3xFcjzuVXdS6QW21pK7rZeN1zluZwGehAq+Lk68ohVJLnbtnORdC
	 6/6QuadUKD0qCP2qDGkSmORkF4MBl5Wdd7cOCwL0RnZT8rEKLWlRK0w4P65vQqkaDzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eHXQ75jb;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B3606A31F
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 05:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A48B3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eHXQ75jb
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1238161f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 22:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820900; x=1793425700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6qMiNAXonRcpqrHA/noomKNgnzoBcCy6IIUuJqY3UOc=;
        b=eHXQ75jbOsfxPG3i87e1VO0X3uwPAbBy91TM+fOWXtit2BQpXi9n3dTFCKtKvViCf2
         9Uj1tpZjyGw6WXmVGREnAdblX53nevh2tQe3n/LmE2SBvMO5inlY3/Tp3TjtYzCBzhy0
         R6xnpOvuRt56mZrPbYtPR1DZFp5BJOzucSElqaYBf8MnLWnS4A/KSfPEbAdjuyTX/0xM
         z+ke58s5zokAoOJAFlvEtUb4KXCiEnvZFizByPnR4fKsZ4iJRgcuP6RlCv1I74H0f5oL
         BSOUj3ays7QEJTYf6EmD7rPAS983u/xtjFClZtqAGMvJtXFilpeTwfyrf80K7mFcnfPP
         nzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820900; x=1793425700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6qMiNAXonRcpqrHA/noomKNgnzoBcCy6IIUuJqY3UOc=;
        b=cGyzqTM9LHlQ+Pr15gA5D6bNDnYU460eqc81ycjnl0BOMWkX77ccYNn3+fWKzwkILS
         +DvrFwd6j5kmED13mUA1S6BEAsAd6qvrWzLoKcBObBurS9g15hwjGthxbsX8kV80zSF9
         +yathB1H8eFJE6hD6ZSge/kKVvF0T9sP7RLhejuiiLQhyL4WfNEQLjHuwZqlUcw2GKF9
         uga/yDSbWXdviVL3pLp/ZXyk39Dy7gDQL2sy0tI/o/7FI+OnYn8FAew/4DX7fu+j+uc5
         mdDxYFzIZzrpKdwDhxuAFvZ2YBuYpgzjF1NzdDIRLajaGK+h90xLnwgbk06M+W5mNYQ1
         LjkQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYH5Xyrz6peUHWbFXhfMNTMSsE1G215Scm5/XY37JBS4BXLcCaLFB3Q8UbWic4r/rrFj7SvjlAHlU=@vger.kernel.org
X-Gm-Message-State: AFq9FYITo7raHP0clrEsmzXz2LF2nwMHSOAmfKjPW9TevSdVevGipaeq
	sf0yNNlYXhVuN6/GJUNn2CsRyFjQB+THySuVseHzDkQnEE+Zz3K6s07x
X-Gm-Gg: AYBFou0TIxKVsTzkzg951DLn8Jfy9zv1KdqhGoc4sECxZHYYJnJNVsZofJhf6tzy96n
	m/EQFOQd3Dwm0fhYM8F4jH8zYpAjJULYdSkYEu10gVtBjPIF/1pxfVtov8CChV516B04I9etM6o
	DfZuyOzYKG5TlxWCMvQ2HnTEBU+UaP3/uu8taQJPq44AzF6qrHL6WkOyUEBdeqa7RaFS+qQ8c9D
	z77HdAv1xvjWsdOoaTwoOJN37DlTXKCOhc6eZ3sTuwW9tQ6vvTfJKzqjJDxMR8+YYAS6FphzuNW
	69t9JNC6SeCss0ZvpGXXjQt2BwIQ8o5PGuh9W1VN2Dq46kqPMJvysQCxQ8WVbUhBqMrVrmAhi8y
	qeVuLSXLKP0H6QK0duyfxFA5pqLtwE/C4VZ66SgCKpg0h52Q52KCpo0/lUEeBKcfbH5M8t/0rWw
	0J2bc6/SSy2oO0jGhnAlW+e6KkvuM806Nq8sYH+fOivKiOJ7nFiAW3PPdSfq9rGgQKRK2cdHJJw
	A0Gy8b+1wL7XxX9M/gRwjdr4MiRQt3ePdfGnK/BHOGTqfGsG1mhYxlNCX62FiCz5DjLHLoyNjQs
	ymQ=
X-Received: by 2002:a05:600c:1987:b0:4a1:db17:c7e6 with SMTP id 5b1f17b1804b1-4a35ac3a7b1mr13113545e9.2.1792820899903;
        Fri, 23 Oct 2026 22:48:19 -0700 (PDT)
Received: from Sheldon ([185.4.35.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2d6f6fsm30737725e9.12.2026.10.23.22.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:48:19 -0700 (PDT)
From: Victor Carreras <vicajilau@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Victor Carreras <vicajilau@gmail.com>
Subject: Re: [PATCH] PCI: Disable ACPI wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Sat, 24 Oct 2026 07:48:18 +0200
Message-ID: <20261024054818.21654-1-vicajilau@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atsWqqpFptswGQKy@wunner.de>
References: <atsWqqpFptswGQKy@wunner.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 23, 2026 at 10:11:22AM +0200, Lukas Wunner wrote:
> This is x86-specific but drivers/pci/quirks.c is used by all arches.
> It should rather live e.g. in drivers/acpi/x86/utils.c.

Thanks for the review, Lukas. I have moved the quirk to
drivers/acpi/x86/utils.c in v2 (and dropped clearing
adev->wakeup.flags.valid so pci_acpi_setup()/pci_acpi_cleanup() power
dependent tracking remains balanced).

Best regards,
Victor
