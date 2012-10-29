Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56097 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab2J2HQ2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:16:28 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4989831vbb.19
        for <linux-pci@vger.kernel.org>; Mon, 29 Oct 2012 00:16:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1351492562.git.pratyush.anand@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
Date: Mon, 29 Oct 2012 12:46:27 +0530
Message-ID: <CAOh2x=mFS7awO7eoD4zA-sEzg0wY8KNjzTCcXMhOrqBhRcodKA@mail.gmail.com>
Subject: Re: [PATCH 00/15] SPEAr13xx PCIe patches
From: viresh kumar <viresh.kumar@linaro.org>
To: Pratyush Anand <pratyush.anand@st.com>, arm@kernel.org
Cc: arnd@arndb.de, shiraz.hashim@st.com, spear-devel@list.st.com,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	olof@lixom.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 29, 2012 at 12:31 PM, Pratyush Anand <pratyush.anand@st.com> wrote:
> -- First two patches are common for all platforms on ARM architecture.
> -- Remaining patches belongs to SPEAr13xx architecture.
> -- SPEAr13xx supports both RC and EP mode of PCIe interface. This patchset
>         supports only RC mode.

Hi Pratyush,

For ARM SoC specific patches, that you want Arnd or Olof to apply, please send
them to arm@kernel.org. Arnd and Olof push ARM SoC trees in turns and they
pick them from arm@kernel.org.

--
viresh
