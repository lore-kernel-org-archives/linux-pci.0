Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Jun 2018 14:08:50 +0900 (KST)
Message-Id: <20180622.140850.2131338572840772705.davem@davemloft.net>
To: kai.heng.feng@canonical.com
Cc: ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        hkallweit1@gmail.com, romieu@fr.zoreil.com, bhelgaas@google.com,
        acelan.kao@canonical.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] r8169: Reinstate ASPM Support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180621083039.22545-2-kai.heng.feng@canonical.com>
References: <20180621083039.22545-1-kai.heng.feng@canonical.com>
        <20180621083039.22545-2-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 21 Jun 2018 16:30:39 +0800

> On Intel platforms (Skylake and newer), ASPM support in r8169 is the
> last missing puzzle to let CPU's Package C-State reaches PC8.  Without
> ASPM support, the CPU cannot reach beyond PC3. PC8 can save additional
> ~3W in comparison with PC3 on a Coffee Lake platform, Dell G3 3779.
> 
> This is based on the work from Chunhao Lin <hau@realtek.com>.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Also applied.

Thank you for being so persistent.
