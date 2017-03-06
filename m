Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lb1.openmailbox.org ([5.79.108.160]:56511 "EHLO
        mail.openmailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754184AbdCFVvk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2017 16:51:40 -0500
Received: from www.openmailbox.org (unknown [10.0.0.3])
        by mail.openmailbox.org (Postfix) with ESMTP id CEAFF512142
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2017 22:26:49 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 06 Mar 2017 23:26:49 +0200
From: sonofagun@openmailbox.org
To: linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] drm/amdgpu: resize VRAM BAR for CPU access
Message-ID: <073b62f3aa822f2a1f4966232d9bf55d@openmailbox.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> +		DRM_INFO("Not enoigh PCI address space for a large BAR.");

Please fix the typo of the message so that another patch is not needed 
in the future!
