Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 6 Jun 2015 19:00:10 +0200
From: Borislav Petkov <bp@alien8.de>
To: Wan ZongShun <Vincent.Wan@amd.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
	linux-i2c@vger.kernel.org, jdelvare@suse.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH 1/3] pci_ids: Add AMD KERNCZ device ID support
Message-ID: <20150606170010.GE545@pd.tnic>
References: <1433596420-5612-1-git-send-email-Vincent.Wan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1433596420-5612-1-git-send-email-Vincent.Wan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 06, 2015 at 09:13:38PM +0800, Wan ZongShun wrote:
> The KERNCZ is new AMD SB/FCH generation name, like HUDSON2.
> We will adopt 0x790b as device ID since from this gereration.
> 
> Signed-off-by: Wan ZongShun <Vincent.Wan@amd.com>
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

You need to choose one email address, not two for the same person's
Signed-off-by line. I'd prefer the amd.com one.

For more info, please read Documentation/SubmittingPatches.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
