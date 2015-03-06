Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54F9BCDC.5000500@mm-sol.com>
Date: Fri, 06 Mar 2015 16:42:36 +0200
From: Stanimir Varbanov <svarbanov@mm-sol.com>
MIME-Version: 1.0
To: "Matwey V. Kornilov" <matwey@sai.msu.ru>, bhelgaas@google.com
CC: mohit.kumar@st.com, viresh.kumar@linaro.org,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pci: spear: Drop __initdata from spear13xx_pcie_driver
References: <1424367708-17149-1-git-send-email-matwey@sai.msu.ru>
In-Reply-To: <1424367708-17149-1-git-send-email-matwey@sai.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/19/2015 07:41 PM, Matwey V. Kornilov wrote:
> spear13xx_pcie_driver.driver is allocated in text.init section
> and then the pointer to it is passed futher. This patch is to avoid
> crashes like the following, when freed memory is used.
> 

What happened with this patch, could it go as a fix?

-- 
regards,
Stan
