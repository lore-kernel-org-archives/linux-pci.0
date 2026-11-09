Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232249;
	b=KH9SoEOklO++7qJZfvpNGqL0uytaW0lBQ3LTJSMz3c4xbvraD+0qXukqI1MVm8jJf36W
	 N76e/VJfpcVqxc7Lj5u273/8wEQK4oKOqPGgVq4kqsjZ1hxKUtdnMd1QuDvxNiI/WKKrL
	 MmEWI+tds8ypJ+WxosWQ6PCcoE5JZc6ZkYAZzwsauHpZBB6Ohv957tT5AEuWmz0xu0aNS
	 H9x7lAnLlWhWk1AULjDT/YSLfOE8EipXlghkbRypSMJYRbWT0RD9x/aEUTyWI4fEysl0Y
	 H63YEi/kZApgwlcC68vGjWWoYHohvm1geY9YTiQxOccnyQTN6eUH0g5KDRI+JwTVqcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232249;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:In-Reply-To:References:Subject:
	 From:Cc:To:Date:Message-ID:User-Agent;
	bh=fk+ULn+LiMYolzMljOxfZYHMNqgMG1FKUhWrEn7F8iI=;
	b=f3CcvXoIndlo/1FQfYqHlrKx6AEweojgIstAPJsi0++HSRAXt4yDXm0ep5TUXvgyn7jM
	 Iob+mX5qbXaoe4ETZ7k9RjZWkMRwN+KHxEC8RvdfG9xyD145pk+KcXKQDYjfJVSmIIcfX
	 vlXEuKN2U5iucx09E55oDoE1zLz8K+zhlKc/mGp5b8yO0c8z7yLbhQlipkuEFaDuf8jja
	 FyB+WGCW/wahtNRhZL8bbW0IVCeDAZDF3Jvfx6wNe8Nqk0UgB3je776iwQPNvWkR4pNIK
	 Zxs7Pf2CD4X2aGarQyV9eXpLgV8WIeX3mo8ScdTRLAkORO7cgQHQIFJ+QssTlFS88wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M8zLzQAW;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477E606A323;
	Mon,  9 Nov 2026 13:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D477E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M8zLzQAW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794232247; x=1825768247;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=fk+ULn+LiMYolzMljOxfZYHMNqgMG1FKUhWrEn7F8iI=;
  b=M8zLzQAWzwL4X+pmhJLXkrOKsJaID5u5H+GbXsMoRlSF1mPJqSG9HWN3
   22uyYCTMIJ4iTvJfwUPzru+vvlRbdmP6CILujMjF069KCGBu7hIOnDehp
   jNj9kI40sIcm940nN5tyDAUbZCgP90Mq5oCWMY2it46Gff8j8ZPTaQiMZ
   1Kyp767u78KG1ezeVRtLeeTps3h71wMotgtWj7bVNIP3NA6sSWsVVbX02
   h7o1MBa/6it9VbwCRaKksOYaB/FOz9RbYyVlaD9e8fDF5eGcf0PLJqOQZ
   EeJYXgw6/zNWWgMfXkvPaTwuXMy3jkQSTNzivlIejGfEGJBf1zvr27O33
   Q==;
X-CSE-ConnectionGUID: eUskkGoGR3mZhmsVknAthA==
X-CSE-MsgGUID: x1R4566SQteLPSLmaxRiNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2985771"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2985771"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:50:47 -0800
X-CSE-ConnectionGUID: seZ/F5gVRPiD6OPQFxKKUQ==
X-CSE-MsgGUID: eQlnhf9cQb215+SktPBVAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7897628"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:50:43 -0800
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261109131011.1815-4-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com> <20261109131011.1815-4-ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 3/3] drm/i915: Remove driver side resource assignment after BAR resize
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@gmail.com>, Ilpo =?utf-8?q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Mon, 09 Nov 2026 15:50:40 +0200
Message-ID: <179423224043.176713.9574389595098924070@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620

Quoting Ilpo J=C3=A4rvinen (2026-11-09 15:10:10)
> pci_resize_resource() assigns the resized BAR and the other BARs it
> released, or restores the original configuration on failure. Calling
> pci_assign_unassigned_bus_resources() after it is redundant. If that
> call manages to assign more resources in some scenario, the problem
> should be fixed inside pci_resize_resource() instead.
>=20
> Remove the pci_assign_unassigned_bus_resources() call from
> i915_resize_lmem_bar().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Feel free to apply on pci tree where the refactoring also landed.

Regards, Joonas
