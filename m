Return-Path: <SRS0=ofcB=C3=gmail.com=ckoenig.leichtzumerken@kernel.org>
Return-Path: <SRS0=ofcB=C3=gmail.com=ckoenig.leichtzumerken@kernel.org>
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
To: helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Fixes for 64bit window handling on AMD CPUs
Date: Wed, 29 Nov 2017 15:12:26 +0100
Message-Id: <20171129141229.6107-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

please include the following three patches in your next fix pull request for -rc2.

They just restrict the fixup of the 64bit window on AMD CPU to avoid problems with Xen and multi socket systems.

If you prefer a pull request just say so and I will setup a branch on a public server.

Thanks,
Christian.
