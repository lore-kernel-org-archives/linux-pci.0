Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:38585 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeF2TkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jun 2018 15:40:22 -0400
Received: by mail-qt0-f176.google.com with SMTP id c5-v6so8877459qth.5
        for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2018 12:40:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625210606.2736-6-alexander.deucher@amd.com>
References: <20180625210606.2736-1-alexander.deucher@amd.com> <20180625210606.2736-6-alexander.deucher@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 30 Jun 2018 05:40:21 +1000
Message-ID: <CAPM=9txYNvVxJGxDo3122msDe=OXHKW0r7M92DkVgaSxjz68mg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm: drop drm_pcie_get_speed_cap_mask and drm_pcie_get_max_link_width
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26 June 2018 at 07:06, Alex Deucher <alexdeucher@gmail.com> wrote:
> These functions duplicated functionality which was ultimately added
> to the pci core.
>
> All users of these functions have been ported to using the newly
> exposed pci functionality.  These functions are no longer used,
> so drop them.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>

Dave.
